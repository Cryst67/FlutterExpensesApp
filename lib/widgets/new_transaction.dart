import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './adaptive_el_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;
  NewTransaction(this.addNewTransaction);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;
  void _Submit() {
    if (_amountController.text.isEmpty) return;
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);
    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;
    widget.addNewTransaction(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context).pop(); //collapse opened input form
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
    ).then((e) {
      if (e == null) return;
      setState(() {
        _selectedDate = e;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 2,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Platform.isIOS
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: CupertinoTextField(
                      autofocus: true,
                      placeholder: 'Title',
                      controller: _titleController,
                      onSubmitted: (_) => _Submit(),
                    ),
                  )
                : TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: _titleController,
                    onSubmitted: (_) => _Submit(),
                    //onChanged: ((e) => titleInput = e),
                  ),
            Platform.isIOS
                ? CupertinoTextField(
                    placeholder: 'Amount',
                    controller: _amountController,
                    keyboardType: TextInputType.numberWithOptions(),
                    onSubmitted: (_) => _Submit(),
                  )
                : TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: _amountController,
                    keyboardType: TextInputType.numberWithOptions(),
                    onSubmitted: (_) => _Submit(),
                    //onChanged: ((e) => amountInput = e),
                  ),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate == null
                        ? 'No Date Picked'
                        : 'Selected Date: ${DateFormat.yMMMd().format(_selectedDate)}',
                    style: Platform.isIOS
                        ? TextStyle(color: Color.fromARGB(255, 107, 106, 106))
                        : TextStyle(),
                  ),
                  Platform.isIOS
                      ? CupertinoButton(
                          child: Text('Choose Date'),
                          onPressed: _presentDatePicker)
                      : TextButton(
                          onPressed: _presentDatePicker,
                          child: Text(
                            'Choose Date',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                ],
              ),
            ),
            AdaptiveElButton(_Submit),
          ]),
        ),
      ),
    );
  }
}
