import '../../domain/entities/timetable_slot.dart';
import '../../domain/entities/course.dart';
import '../../domain/repositories/timetable_repository.dart';
import '../../domain/value_objects/term.dart';
import '../datasources/manabo_timetable_remote_ds.dart';
import '../datasources/cubics_timetable_remote_ds.dart';
import '../datasources/manabo_class_remote_ds.dart';
import '../parsers/manabo_timetable_parser.dart';

/// 時間割リポジトリ実装
class TimetableRepositoryImpl implements TimetableRepository {
  const TimetableRepositoryImpl({
    required ManaboTimetableRemoteDataSource manaboTimetableDataSource,
    required CubicsTimetableRemoteDataSource cubicsTimetableDataSource,
    required ManaboClassRemoteDataSource manaboClassDataSource,
  }) : _manaboTimetableDataSource = manaboTimetableDataSource,
       _cubicsTimetableDataSource = cubicsTimetableDataSource,
       _manaboClassDataSource = manaboClassDataSource;

  final ManaboTimetableRemoteDataSource _manaboTimetableDataSource;
  final CubicsTimetableRemoteDataSource _cubicsTimetableDataSource;
  final ManaboClassRemoteDataSource _manaboClassDataSource;

  @override
  Future<List<TimetableSlot>> getTimetable(
    Term term, {
    bool forceRefresh = false,
  }) async {
    try {
      // MaNaBoから時間割HTMLを取得
      final htmlContent = await _manaboTimetableDataSource.fetchTimetableHtml(
        term.archiveId,
      );

      // HTMLをパースしてスロットDTOに変換
      final slotDtos = ManaboTimetableParser.parseTimeTable(htmlContent);

      // DTOをドメインエンティティに変換
      final slots = <TimetableSlot>[];
      for (final dto in slotDtos) {
        final weekday = _convertToWeekday(dto.weekday);
        final period = _convertToPeriod(dto.period);

        if (weekday != null && period != null) {
          Course? course;
          if (dto.courseName != null && dto.manaboClassId != null) {
            course = Course(
              id: dto.manaboClassId.toString(),
              title: dto.courseName!,
              teacher: dto.teacher ?? '',
              room: dto.room,
              manaboClassId: dto.manaboClassId!,
              courseCode: dto.courseCode,
            );
          }

          slots.add(
            TimetableSlot(
              id: '${term.archiveId}_${dto.weekday}_${dto.period}',
              term: term,
              weekday: weekday,
              period: period,
              course: course,
              room: dto.room,
            ),
          );
        }
      }

      return slots;
    } catch (e) {
      // TODO: 適切なAppExceptionに変換
      rethrow;
    }
  }

  @override
  Future<CourseDetail> getCourseDetail(int manaboClassId) async {
    try {
      // 並行して各種情報を取得
      final futures = await Future.wait([
        _manaboClassDataSource.fetchDirectory(manaboClassId),
        _manaboClassDataSource.fetchNews(manaboClassId),
        _manaboClassDataSource.fetchSyllabus(manaboClassId),
      ]);

      final directoryHtml = futures[0];
      final newsHtml = futures[1];
      final syllabusHtml = futures[2];

      // TODO: HTMLパーサーで解析してドメインエンティティに変換
      // 現在は仮実装
      final course = Course(
        id: manaboClassId.toString(),
        title: 'TODO: Parse from HTML',
        teacher: 'TODO: Parse from HTML',
        manaboClassId: manaboClassId,
      );

      return CourseDetail(
        course: course,
        materials: [], // TODO: Parse from directory HTML
        news: [], // TODO: Parse from news HTML
        // syllabus: TODO: Parse from syllabus HTML
      );
    } catch (e) {
      // TODO: 適切なAppExceptionに変換
      rethrow;
    }
  }

  @override
  Future<List<Term>> getAvailableTerms() async {
    try {
      final htmlContent = await _manaboTimetableDataSource
          .fetchAvailableTermsHtml();
      final termMaps = ManaboTimetableParser.parseAvailableTerms(htmlContent);

      final terms = <Term>[];
      for (final termMap in termMaps) {
        final archiveId = termMap['archiveId'] as int;
        final displayName = termMap['displayName'] as String;

        // 表示名から年度と学期を推定
        final yearMatch = RegExp(r'(\d{4})').firstMatch(displayName);
        final year = yearMatch != null
            ? int.parse(yearMatch.group(1)!)
            : DateTime.now().year;

        final semester = displayName.contains('春')
            ? Semester.spring
            : Semester.autumn;

        terms.add(
          Term(
            archiveId: archiveId,
            year: year,
            semester: semester,
            displayName: displayName,
          ),
        );
      }

      return terms;
    } catch (e) {
      // TODO: 適切なAppExceptionに変換
      rethrow;
    }
  }

  /// 数値からWeekdayに変換
  Weekday? _convertToWeekday(int weekdayNum) {
    switch (weekdayNum) {
      case 1:
        return Weekday.monday;
      case 2:
        return Weekday.tuesday;
      case 3:
        return Weekday.wednesday;
      case 4:
        return Weekday.thursday;
      case 5:
        return Weekday.friday;
      case 6:
        return Weekday.saturday;
      case 7:
        return Weekday.sunday;
      default:
        return null;
    }
  }

  /// 数値からPeriodに変換
  Period? _convertToPeriod(int periodNum) {
    return Period.fromNumber(periodNum);
  }
}
