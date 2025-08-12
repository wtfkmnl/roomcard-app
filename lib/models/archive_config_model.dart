import 'dart:convert' show json;

class ArchiveConfigModel {
  String? bUcket;
  String? dOwnloadSite;
  String? iNvitationCode;
  String? lAngguageCode;
  String? oSKey;
  String? pT;
  String? pTId;
  String? sIte;
  String? opKey;

  /// siteType(V1黑色版本(可换肤)  V2:88club V3:白色) 默认V3
  String? siteType;

  ArchiveConfigModel.fromParams({
    this.bUcket,
    this.dOwnloadSite,
    this.iNvitationCode,
    this.lAngguageCode,
    this.oSKey,
    this.pT,
    this.pTId,
    this.sIte,
    this.siteType,
    this.opKey,
  });

  factory ArchiveConfigModel(Object jsonStr) => jsonStr is String ? ArchiveConfigModel.fromJson(json.decode(jsonStr)) : ArchiveConfigModel.fromJson(jsonStr);

  static ArchiveConfigModel? parse(jsonStr) => ['null', '', null].contains(jsonStr) ? null : ArchiveConfigModel(jsonStr);

  ArchiveConfigModel.fromJson(jsonRes) {
    bUcket = jsonRes['b_ucket'];
    dOwnloadSite = jsonRes['d_ownloadSite'];
    iNvitationCode = jsonRes['i_nvitationCode'];
    lAngguageCode = jsonRes['l_angguageCode'];
    oSKey = jsonRes['o_sKey'];
    pT = jsonRes['p_t'];
    pTId = jsonRes['p_tId'];
    sIte = jsonRes['s_ite'];
    siteType = jsonRes['s_iteType'];
    opKey = jsonRes['o_pKey'];
  }

  @override
  String toString() {
    return '{"b_ucket": ${bUcket != null ? '${json.encode(bUcket)}' : 'null'}, "d_ownloadSite": ${dOwnloadSite != null ? '${json.encode(dOwnloadSite)}' : 'null'}, "i_nvitationCode": ${iNvitationCode != null ? '${json.encode(iNvitationCode)}' : 'null'}, "l_angguageCode": ${lAngguageCode != null ? '${json.encode(lAngguageCode)}' : 'null'}, "o_sKey": ${oSKey != null ? '${json.encode(oSKey)}' : 'null'}, "p_t": ${pT != null ? '${json.encode(pT)}' : 'null'}, "p_tId": ${pTId != null ? '${json.encode(pTId)}' : 'null'}, "s_ite": ${sIte != null ? '${json.encode(sIte)}' : 'null'}}';
  }

  String toJson() => this.toString();
}
