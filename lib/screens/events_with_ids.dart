import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:id_scanner/widgets/internet_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../app_data.dart';

import '../components/custom_widgets.dart';
import '../components/input_filed_decoration.dart';
import '../controllers/card_controller.dart';
import '../models/events_model.dart';
import '../widgets/cards_list.dart';


class EventsWihIds extends StatefulWidget {
  const EventsWihIds({Key? key}) : super(key: key);
static const String id = '/events';

  @override
  State<EventsWihIds> createState() => _EventsWihIdsState();
}

class _EventsWihIdsState extends State<EventsWihIds> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CardController>(
      init: CardController(),
      builder: (controller) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: InterNetWidget(

            widget: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: const Text('النشاط '),
                centerTitle: true,
                  
              ),
              body: ModalProgressHUD(
             progressIndicator: CircularProgressIndicator(
                color: AppData.mainColor,
              ),
            inAsyncCall: controller.isLoading,
            child: Column(
              children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                                                              inputLabel('النشاط'),
                                    const SizedBox(height: 5),
                                    controller.loading
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : DropdownButtonFormField2(
                                            decoration: kAddCardInputFieldDecoration,
                                            isExpanded: true,
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            iconSize: 30,
                                            buttonHeight: 50,
                                            buttonPadding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            dropdownDecoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            items: controller.eventObject.data
                                                .map<DropdownMenuItem<EventDatum>>(
                                                    (EventDatum event) {
                                              return DropdownMenuItem<EventDatum>(
                                                value: event,
                                                child: Text(
                                                  event.eventName.capitalize.toString(),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (EventDatum? newValue) {
                                              controller.selected = newValue;
                                            },
                                           
                                          ),
                        ],
                      ),
                    ),
                    
                const Expanded(child: CardsList()),
              ],
            ),
          ),
                  
            ),
          ),
        );
      },
    );
  }
}