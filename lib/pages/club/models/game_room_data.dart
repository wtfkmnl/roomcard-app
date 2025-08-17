/// 游戏房间数据模型
class GameRoomData {
  /// 游戏类型名称
  final String gameTypeName;
  
  /// 当前玩家数量
  final int currentPlayers;
  
  /// 最大玩家数量
  final int maxPlayers;
  
  /// 总玩家数量（包括观战者）
  final int totalPlayers;
  
  /// 游戏变体
  final String gameVariant;
  
  /// 房间名称
  final String roomName;
  
  /// 可用牌桌数量
  final int availableTables;
  
  /// 创建者头像
  final String creatorAvatar;
  
  /// 创建者昵称
  final String creatorName;

  GameRoomData({
    required this.gameTypeName,
    required this.currentPlayers,
    required this.maxPlayers,
    required this.totalPlayers,
    required this.gameVariant,
    required this.roomName,
    required this.availableTables,
    required this.creatorAvatar,
    required this.creatorName,
  });
} 