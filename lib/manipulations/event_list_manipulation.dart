import '../models/event.dart';
import '../models/event_list.dart';

class EventListManipulation {

  EventList filterStartDateRange(EventList events, DateTime start, DateTime end){
    EventList filteredEvents = EventList(events.events);


    return filteredEvents;
  }
}