/// 俱乐部卡片数据模型
class ClubCardData {
  final String title;
  final String clubId;
  final int memberCount;
  final bool isCreator;
  final bool isPublic;
  final int activeGames;
  final String avatarPath;

  ClubCardData({
    required this.title,
    required this.clubId,
    required this.memberCount,
    required this.isCreator,
    required this.isPublic,
    required this.activeGames,
    required this.avatarPath,
  });
} 