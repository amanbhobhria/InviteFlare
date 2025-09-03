import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:if_loop_components/if_loop_components.dart';
import 'package:intl/intl.dart';
import 'package:invite_flare/core/core.dart';
import 'package:invite_flare/core/di/di.dart';
import 'package:invite_flare/core/widgets/dialog/snack_bar_utils.dart';
import 'package:invite_flare/features/event_details/presentation/blocs/event_details_bloc/event_details_bloc.dart';
import 'package:invite_flare/shared/domain/entities/guest_entity.dart';
import 'package:invite_flare/shared/presentation/widgets/date_time_picker/date_time_picker.dart';

import 'package:invite_flare/shared/shared.dart';

class EventDetailsWrapper extends StatelessWidget {
  const EventDetailsWrapper({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getIt<EventDetailsBloc>(),
        child: const _EventDetailsWrapper(),
      );
}

class _EventDetailsWrapper extends StatefulWidget {
  const _EventDetailsWrapper();

  @override
  State<_EventDetailsWrapper> createState() => _EventDetailsWrapperState();
}

class _EventDetailsWrapperState extends State<_EventDetailsWrapper>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  void _nextTab() {
    if (_tabController.index < _tabController.length - 1) {
      _tabController.animateTo(_tabController.index + 1);
    }
  }

  void _prevTab() {
    if (_tabController.index > 0) {
      _tabController.animateTo(_tabController.index - 1);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: const AppBarView.other(
            pageTitle: 'Please fill Details',
          ),
          body: BlocListener<EventDetailsBloc, EventDetailsState>(
            listener: (context, state) {
              if (state is EventDetailsSubmitSuccess) {
                if (_tabController.index < _tabController.length - 1) {
                  _tabController.animateTo(_tabController.index + 1);
                }
                context.read<EventDetailsBloc>().add(EventDetailsChangeTabEvent(
                    index: _tabController.index + 1));
              } else if (state is EventDetailsSubmitFailure) {
                SnackBarUtils.show(
                    context: context, message: 'Failed to save event info');
              }
              else if (state is GuestInfoSubmitSuccess) {
                showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Success'),
                    content: const Text('Event created successfully!'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(ctx).pop(); // close dialog
                          Navigator.of(context).pop(); // close screen
                        },
                        child: const Text('Finish'),
                      ),
                    ],
                  ),
                );
              }
            },
            child: BlocBuilder<EventDetailsBloc, EventDetailsState>(
              builder: (context, state) {
                final bloc = context.read<EventDetailsBloc>();
                return Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      onTap: (v) {
                        if (v < _tabController.length - 1) {
                          _tabController.animateTo(v);
                        }
                        bloc.add(EventDetailsChangeTabEvent(index: v));
                      },
                      tabs: const [
                        Tab(text: 'Event Details'),
                        Tab(text: 'RSVP Settings'),
                        Tab(text: 'Add Guest'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _eventDetail(context: context, bloc: bloc),
                          _rsvpView(context: context, bloc: bloc),
                          _addGuest(context: context, bloc: bloc)
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Visibility(
                            visible: _tabController.index > 0,
                            child: IFButton(
                              text: 'Back',
                              onPressed: () {
                                if (_tabController.index > 0) {
                                  _tabController
                                      .animateTo(_tabController.index - 1);
                                }
                                bloc.add(EventDetailsChangeTabEvent(
                                    index: _tabController.index - 1));
                              },
                              buttonSize: IFButtonSize.MIN,
                              buttonType: IFButtonType.SECONDARY,
                              buttonStyle: IFButtonStyle.OUTLINE,
                            ),
                          ),
                          const Spacer(),
                          IFButton(
                            text: _tabController.index == 2 ? 'Finish' : 'Next',
                            onPressed: () {
                              bool isValid = true;

                              if (_tabController.index == 0) {
                                if (bloc.cEventTitle.text.isEmpty ||
                                    bloc.cHostedBy.text.isEmpty ||
                                    bloc.cEventDateTime.text.isEmpty ||
                                    (!bloc.needVirtualLocation &&
                                        bloc.cAddress.text.isEmpty) ||
                                    (bloc.needVirtualLocation &&
                                        bloc.cVirtualLocation.text.isEmpty)) {
                                  isValid = false;
                                }
                              } else if (_tabController.index == 1) {
                                if (bloc.needRSVPCollect &&
                                    bloc.cRSVPDeadline.text.isEmpty) {
                                  isValid = false;
                                }
                                if (bloc.allowToBringAdditionalGuests ==
                                        'Yes' &&
                                    bloc.cGuestLimit.text.isEmpty) {
                                  isValid = false;
                                }
                              }

                              if (!isValid) {
                                SnackBarUtils.show(
                                    context: context,
                                    message: 'Please fill all required fields');
                                return;
                              }

                              // On RSVP tab, call API via BLoC event
                              if (_tabController.index == 1) {
                                context
                                    .read<EventDetailsBloc>()
                                    .add(SubmitEventInfoEvent("41nDOPdmKQRL"));
                                return;
                              }

                              // On Add Guest tab and Finish button
                              else if (_tabController.index == 2) {
                                context
                                    .read<EventDetailsBloc>()
                                    .add(SubmitGuestInfoEvent("41nDOPdmKQRL"));
                              }
                              // Otherwise, go to next tab
                              else if (_tabController.index <
                                  _tabController.length - 1) {
                                _tabController
                                    .animateTo(_tabController.index + 1);
                                bloc.add(EventDetailsChangeTabEvent(
                                    index: _tabController.index + 1));
                              }
                            },
                            buttonSize: IFButtonSize.MIN,
                            buttonType: IFButtonType.SECONDARY,
                          )
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      );

  Widget _eventDetail(
          {required BuildContext context, required EventDetailsBloc bloc}) =>
      SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const IFSpace(),
                TextFieldWrapper(
                  controller: bloc.cEventTitle,
                  hintText: 'Event Title',
                  isRequired: true,
                  textFieldType: TextFieldType.OTHERS,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
                const IFSpace(),
                TextFieldWrapper(
                  controller: bloc.cHostedBy,
                  hintText: 'Hosted by',
                  isRequired: true,
                  textFieldType: TextFieldType.TEXT,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
                const IFSpace(),
                TextFieldWrapper(
                  controller: bloc.cEventDateTime,
                  hintText: 'Event Date & Time',
                  isRequired: true,
                  textFieldType: TextFieldType.OTHERS,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                  onTap: () async {
                    var date = await DateTimePicker.dateTimePicker(
                      context: context,
                      helpText: 'Select Event Date',
                    );
                    if (date != null) {
                      bloc.cEventDateTime.text =
                          DateFormat('dd MMM yyyy, hh:mm a').format(date);
                    }
                  },
                ),
                const IFSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const IFText(text: 'Virtual Location'),
                    Switch.adaptive(
                      value: bloc.needVirtualLocation,
                      onChanged: (value) {
                        bloc.cAddress.clear();
                        bloc.cLocation.clear();
                        bloc.cVirtualLocation.clear();
                        context.read<EventDetailsBloc>().add(
                            const EventDetailsSwitchEvent(
                                switchAction: SwitchAction.virtualLocation));
                      },
                    ),
                  ],
                ),
                const IFSpace(),
                if (!bloc.needVirtualLocation) ...[
                  TextFieldWrapper(
                    controller: bloc.cAddress,
                    hintText: 'Address',
                    isRequired: true,
                    textFieldType: TextFieldType.OTHERS,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                  ),
                  const IFSpace(),
                  TextFieldWrapper(
                    controller: bloc.cLocation,
                    hintText: 'Location',
                    textFieldType: TextFieldType.OTHERS,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                  ),
                ] else
                  TextFieldWrapper(
                    controller: bloc.cVirtualLocation,
                    hintText: 'Virtual Location',
                    isRequired: true,
                    textFieldType: TextFieldType.OTHERS,
                    textInputAction: TextInputAction.next,
                    textInputType: TextInputType.name,
                  ),
                const IFSpace(),
                TextFieldWrapper(
                  controller: bloc.cDescription,
                  hintText: 'Description',
                  textFieldType: TextFieldType.OTHERS,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.name,
                ),
                const IFSpace(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const IFText(text: 'Add Confetti'),
                    Switch.adaptive(
                      value: bloc.needAddConfetti,
                      onChanged: (value) {
                        context.read<EventDetailsBloc>().add(
                            const EventDetailsSwitchEvent(
                                switchAction: SwitchAction.addConfetti));
                      },
                    ),
                  ],
                ),
              ],
            )),
      );

  Widget _rsvpView(
          {required BuildContext context, required EventDetailsBloc bloc}) =>
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const IFText(text: 'RSVP Collection'),
                Switch.adaptive(
                  value: bloc.needRSVPCollect,
                  onChanged: (value) {
                    context.read<EventDetailsBloc>().add(
                        const EventDetailsSwitchEvent(
                            switchAction: SwitchAction.rsvpCollect));
                  },
                ),
              ],
            ),
            const IFSpace(),
            if (bloc.needRSVPCollect) ...[
              TextFieldWrapper(
                controller: bloc.cRSVPDeadline,
                hintText: 'RSVP Deadline',
                textFieldType: TextFieldType.OTHERS,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.name,
                onTap: () async {
                  var date = await DateTimePicker.datePicker(
                    context: context,
                    helpText: 'Select Date & Time',
                  );
                  if (date != null) {
                    bloc.cRSVPDeadline.text =
                        DateFormat('dd MMM yyyy').format(date);
                  }
                },
              ),
              const IFSpace(),
              DropdownButtonFormField<String>(
                value: bloc.allowToBringAdditionalGuests,
                decoration: const InputDecoration(
                  labelText: 'Allow to bring additional guests',
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                ),
                items: bloc.items
                    .map((String value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  context
                      .read<EventDetailsBloc>()
                      .add(AllowToBringAdditionalGuestEvent(value: newValue!));
                },
              ),
              if (bloc.allowToBringAdditionalGuests == 'Yes') ...[
                const IFSpace(),
                TextFieldWrapper(
                  controller: bloc.cGuestLimit,
                  hintText: 'Guest Limit',
                  isRequired: true,
                  textFieldType: TextFieldType.INTEGER,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                ),
              ],
              const IFSpace(),
            ],
            TextFieldWrapper(
              controller: bloc.cCustomInviteMessage,
              hintText: 'Custom Invitation Message',
              textFieldType: TextFieldType.OTHERS,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.name,
            ),
            const IFSpace(),
            TextFieldWrapper(
              controller: bloc.cSchedule,
              hintText: 'Schedule',
              textFieldType: TextFieldType.OTHERS,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.name,
              onTap: () async {
                var date = await DateTimePicker.dateTimePicker(
                  context: context,
                  helpText: 'Select Date & Time',
                );
                if (date != null) {
                  bloc.cSchedule.text =
                      DateFormat('dd MMM yyyy, hh:mm a').format(date);
                }
              },
            ),
            const IFSpace(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const IFText(text: 'Send Reminder'),
                Switch.adaptive(
                  value: bloc.needSendReminder,
                  onChanged: (value) {
                    context.read<EventDetailsBloc>().add(
                        const EventDetailsSwitchEvent(
                            switchAction: SwitchAction.sendReminder));
                  },
                ),
              ],
            ),
            const IFSpace(),
          ],
        ),
      );

  Widget _addGuest(
          {required BuildContext context, required EventDetailsBloc bloc}) =>
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWrapper(
              controller: bloc.cGuestName,
              hintText: 'Guest Name',
              isRequired: true,
              textFieldType: TextFieldType.TEXT,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.name,
            ),
            const IFSpace(),
            TextFieldWrapper(
              controller: bloc.cGuestEmail,
              hintText: 'Guest Email',
              isRequired: true,
              textFieldType: TextFieldType.EMAIL,
              textInputAction: TextInputAction.next,
              textInputType: TextInputType.emailAddress,
            ),
            const IFSpace(),
            Row(
              children: [
                PopupMenuButton<String>(
                  onSelected: (value) {
                    // handle selected value
                    print('Selected: $value');
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'download',
                      child: Row(
                        children: [
                          Icon(Icons.download),
                          SizedBox(width: 10),
                          Text('Download Sample'),
                        ],
                      ),
                    ),
                    const PopupMenuItem<String>(
                      value: 'upload',
                      child: Row(
                        children: [
                          Icon(
                            Icons.upload,
                          ),
                          SizedBox(width: 10),
                          Text('Bulk Upload'),
                        ],
                      ),
                    ),
                  ],
                  child: TextButton.icon(
                      onPressed: null,
                      icon: const Icon(Icons.file_upload),
                      label: const IFText(
                        text: 'Bulk Upload',
                      )),
                ),
                const Spacer(),
                IFButton(
                  text: '+ Add Guest',
                  onPressed: () {
                    if (bloc.cGuestName.text.isNotEmpty &&
                        bloc.cGuestEmail.text.isNotEmpty) {
                      bloc.add(OnAddGuestEvent(
                          guest: GuestEntity(
                        id: bloc.guests.length + 1,
                        name: bloc.cGuestName.text,
                        email: bloc.cGuestEmail.text,
                      )));
                    } else {
                      SnackBarUtils.show(
                          context: context,
                          message: 'Please fill all the fields');
                    }
                  },
                  buttonSize: IFButtonSize.MIN,
                ),
              ],
            ),
            const IFSpace(),
            if (bloc.guests.isNotEmpty) ...[
              const IFHeading(
                text: 'Guest List',
              ),
              const IFSpace(),
              Wrap(
                spacing: 8.0, // horizontal spacing
                runSpacing: 4.0, // vertical spacing
                children: bloc.guests
                    .map((chip) => Chip(
                          label: Text(chip.name ?? ''),
                          avatar: const Icon(Icons.person),
                          deleteIcon: const Icon(Icons.close),
                          onDeleted: () {
                            bloc.add(OnRemoveGuestEvent(guest: chip));
                          },
                        ))
                    .toList(),
              ),
            ]
          ],
        ),
      );
}
