import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  void Function(BuildContext)? deleteTapped;
  void Function(BuildContext)? editTapped;
  final bool showEditTile = true;

  ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.deleteTapped,
    required this.editTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: deleteTapped,
            icon: Icons.delete,
            backgroundColor: Colors.redAccent,
            borderRadius: BorderRadius.circular(4),
          ),
          showEditTile
              ? SlidableAction(
                  onPressed: editTapped,
                  icon: Icons.edit,
                  backgroundColor: Colors.blue,
                  borderRadius: BorderRadius.circular(4),
                )
              : Container(),
        ],
      ),
      child: ListTile(
        title: Text(
          name,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
        ),
        subtitle: Text(
          '${dateTime.day} / ${dateTime.month} / ${dateTime.year}',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        trailing: Text(
          '₹ ' + amount,
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
