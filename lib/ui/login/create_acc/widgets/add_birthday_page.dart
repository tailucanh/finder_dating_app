import 'package:chat_app/generated/l10n.dart';
import 'package:chat_app/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../widgets/button_submit_page_view.dart';
import '../create_acc_cubit.dart';

class AddBirthdayPageSection extends StatefulWidget {

  final PageController pageController;
   final CreateAccCubit cubit;
  const AddBirthdayPageSection({super.key,required this.cubit ,required this.pageController});

  @override
  State<AddBirthdayPageSection> createState() => _AddBirthdayPageSectionChildPageState();

}

class _AddBirthdayPageSectionChildPageState extends State<AddBirthdayPageSection> {
  DateTime _focusedDay = DateTime.now().subtract(const Duration(days: 18 * 365));
  DateTime? _selectedDay;
  Key datePickerKey = UniqueKey();

  void _selectDatePicker(DateTime dateTime) async {
    Navigator.pop(context);
    DateTime? datePicker = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate:  DateTime.utc(1900, 01, 01),
        lastDate: _focusedDay,
    );
      if (datePicker != null && datePicker != dateTime) {
        setState(() {
          widget.cubit.changeBirthday(birthday: DateFormat('yyyy-MM-dd').format(datePicker).toString());
          datePickerKey = UniqueKey();
        });
      }

  }


  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<CreateAccCubit, CreateAccState>(
      key: UniqueKey(),
        builder: (context, state) {
        (state.birthday.isNotEmpty) ? (_selectedDay = DateTime.parse(state.birthday)) : _selectedDay = null;

        return Scaffold(
          extendBody: true,
          bottomNavigationBar: BottomAppBar(
            elevation: 0,
            color: Colors.transparent,
            child: ButtonSubmitPageView(
                text:  S().textNextButton,
                color: state.birthday.isEmpty ? Colors.grey : Colors.transparent,
                onPressed: () {
                 (state.birthday.isNotEmpty) ? widget.pageController.nextPage(duration: const Duration(milliseconds: 100), curve: Curves.linear) : null;
                }),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  S().titleAddBirthDayPage,
                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                ),
              ),

              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(left: 15,right: 15,top: 35,bottom: 15),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(233, 64, 87, 0.1),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: InkWell(
                  onTap: () => DialogSelectDate(context: context,selectDate:state.birthday),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_month_rounded, color: Color.fromRGBO(233, 64, 87, 1),),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: Text(state.birthday.isEmpty ? S.current.contentAddBirthDayPage : state.birthday,
                                    style: TextStyle(fontSize: state.birthday.isEmpty ? 14 : 18,
                                        fontWeight: FontWeight.w700,
                                        color:  const Color.fromRGBO(233, 64, 87, 1)),),
                                ),
                              ],
                            )),
                        state.birthday.isNotEmpty ? const Icon(Icons.change_circle_outlined ,color: Color.fromRGBO(233, 64, 87, 1),) : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  S().textNotificationBirthDayPage,
                  style:  TextStyle(
                      fontSize: 14,
                      color:Theme.of(context).brightness == Brightness.light ? Colors.grey.shade600: Colors.grey.shade200,
                      fontWeight: FontWeight.w500),
                ),
              ),

            ],
          ),
        );
      },
    );
  }

  void DialogSelectDate({required BuildContext context, required String selectDate}) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.linear_scale_outlined,
                    size: 40,
                    color: Colors.grey.shade300,
                  )),
              StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                    return  Container(
                      margin: const EdgeInsets.only(top: 5,),
                      child: TableCalendar(
                        key: datePickerKey,
                        locale: Localizations.localeOf(context).countryCode,
                        focusedDay: selectDate.isNotEmpty ? DateTime.parse(selectDate) : _focusedDay,
                        firstDay: DateTime.utc(1900, 01, 01),
                        lastDay: DateTime.now(),
                        selectedDayPredicate: (day) {
                          return isSameDay(_selectedDay, day);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          if (!isSameDay(_selectedDay, selectedDay)) {
                            setState(() {
                              _selectedDay = selectedDay;
                              _focusedDay = focusedDay;
                            });
                          }
                        },
                        headerStyle: const HeaderStyle(
                            formatButtonVisible: false,
                        ),
                        calendarBuilders: CalendarBuilders(
                          headerTitleBuilder: (context, dateTime){
                            return InkWell(
                              onTap: () => _selectDatePicker(dateTime),
                              child: Center(
                                child: Text(DateFormat('yyyy-MM-dd').format(_selectedDay ?? _focusedDay).toString(), style: const TextStyle(
                                    color: Color.fromRGBO(233, 64, 87, 1),
                                    fontSize: 23,
                                    fontWeight: FontWeight.w600
                                ) ,),
                              ),
                            );
                          }
                        ),
                        availableGestures: AvailableGestures.all,
                        daysOfWeekStyle: const DaysOfWeekStyle(
                            weekendStyle: TextStyle(
                              color: Color.fromRGBO(233, 64, 87, 1),)
                        ),
                        calendarStyle: const CalendarStyle(
                          weekendTextStyle: TextStyle(
                            color: Color.fromRGBO(233, 64, 87, 1),),
                          todayDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(248, 87, 109, 0.4),
                          ),
                          selectedDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromRGBO(233, 64, 87, 1),
                          ),

                        ),
                      ),
                    );
                  }
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                child: CustomButton(title: S.current.textSelectDateDialog,
                    onTap: (){
                      setState(() {
                        widget.cubit.changeBirthday(birthday: DateFormat('yyyy-MM-dd').format(_selectedDay!).toString());
                        Navigator.pop(context);
                      });
                    },
                    isBorder: false),
              ),
            ],
          ),
        );
      }

    );
  }



}




