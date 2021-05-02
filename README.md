#  Trips (Example Project)

## Structure

Structure is currently WIP.  For retrieving data, [`URLFlightDataService`](https://github.com/KeenanHauber/Flights-Example-Project-/blob/post-48-hours/Trips%20(Example%20Project)/Data/FlightDataService.swift#L17) provides an interface for asynchronously fetching flight data from [the provided URL](https://firebasestorage.googleapis.com/v0/b/flight-centre-brand.appspot.com/o/developer-test-flights-list.json?alt=media&token=81d93056-9c7f-451d-94b6-3e88eb6fa9ad). `URLFlightDataService` is simply a convenience wrapper for [`JSONDownloadTaskService`](https://github.com/KeenanHauber/Flights-Example-Project-/blob/post-48-hours/Trips%20(Example%20Project)/Data/JSONDownloadTaskService.swift#L17), which is a generic handler for downloading and decoding JSON from a URL.

No additional logic or data formatting has been implemented to connect the interface (which is currently in the middle of prototyping) and the data.

## Difficulties

- Date formatting & string parsing
- Masking & shadows

## Additional notes

- TicketView should be backed by a view controller to provide additional safe area insets to make consistent insetting of content (to avoid the cutout) easier.
- Further work will happen on the branch [post-48-hours](https://github.com/KeenanHauber/Flights-Example-Project-/tree/post-48-hours)
