class EventSale {
  bool isActive;
  String eventTitle;
  String image;
  List<EventSaleList> eventSaleList;

  EventSale({this.isActive, this.eventTitle, this.image, this.eventSaleList});

  EventSale.fromJson(Map<String, dynamic> json) {
    isActive = json['isActive'];
    eventTitle = json['eventTitle'];
    image = json['image'];
    if (json['event_sale_list'] != null) {
      eventSaleList = <EventSaleList>[];
      json['event_sale_list'].forEach((v) {
        eventSaleList.add(new EventSaleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isActive'] = this.isActive;
    data['eventTitle'] = this.eventTitle;
    data['image'] = this.image;
    if (this.eventSaleList != null) {
      data['event_sale_list'] =
          this.eventSaleList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EventSaleList {
  int id;
  String title;
  String image;
  int type;

  EventSaleList({this.id, this.title, this.image, this.type});

  EventSaleList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['type'] = this.type;
    return data;
  }
}
