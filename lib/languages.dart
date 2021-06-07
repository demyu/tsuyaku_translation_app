class Languages {
  
  static const lang = {
    "ar":"Arabic",
    "bg":"Bulgarian",
    "zh":"Chinese",
    "nl":"Dutch",
    "en":"English",
    "fi":"Finnish",
    "fr":"French",
    "de":"German",
    "id":"Indonesian",
    "it":"Italian",
    "ja":"Japanese",
    "ko":"Korean",
    "ms":"Malay",
    "no":"Norwegian",
    "fa":"Persian",
    "pl":"Polish",
    "pt":"Portuguese",
    "ro":"Romanian, Moldavian, Moldovan",
    "ru":"Russian",
    "sv":"Swedish",
    "tr":"Turkish",
  };

  Languages();

  String getAbr(String val){
    List ap = lang.keys.toList();
    List af = lang.values.toList();
    return ap[af.indexOf(val)];
  }

  List<String> getLang(){
    return lang.values.toList();
  }
}