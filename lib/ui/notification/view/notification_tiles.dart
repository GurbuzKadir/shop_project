import 'package:eshop/common/common.dart';

class NotificationTiles extends StatelessWidget {
  final String title, subtitle;
  final Function onTap;
  final bool enable;

  const NotificationTiles({
    Key key,
    this.title,
    this.subtitle,
    this.onTap,
    this.enable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        child: Icon(
          Icons.card_travel_outlined,
          color: Palette.colorBlack,
          size: 32.0,
        ),
      ),
      title: Text(title, style: context.toPop14RegularFont(Palette.colorBlack)),
      subtitle: Text(
        subtitle,
        style: context.toPop10RegularFont(Palette.colorGrey),
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
      ),
      onTap: onTap,
      enabled: enable,
    );
  }
}
