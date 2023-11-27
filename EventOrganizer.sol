// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0 <= 0.9.0;

contract EventOrganizer {
    struct Event {
        address organizer;      // address of the person who is organizing the event
        string name;            // name of the event
        uint date;              // date of the event
        uint price;             // price of the event
        uint ticketcount;       // total tickets for the event
        uint ticketsRemaining;  // remaining tickets for the event
    }

    mapping (uint => Event) public events;                      // details of the event
    mapping (address => mapping(uint => uint)) public tickets;  // information regarding the tickets of an event

    uint public nextId;

    function createEvent(string calldata _name, uint _date, uint _price, uint _ticketCount) public {
        require(block.timestamp < _date, "Event date should be greater than the current date!");
        require(_ticketCount > 0, "Ticket count must be greater than 0!");

        // at the time of event creation, number of tickets and remaining tickets will be same
        events[nextId] = Event(msg.sender, _name, _date, _price, _ticketCount, _ticketCount);

        nextId++;
    }

    function buyTickets(uint _eventId, uint _quantity) public payable {
        require(events[_eventId].date != 0, "Event doesn't exist!");
        require(events[_eventId].date > block.timestamp, "Event has expired!");

        Event storage _event = events[_eventId];

        require(msg.value == (_event.price * _quantity), "Insufficient balance!");
        require(_event.ticketsRemaining >= _quantity, "Not enough tickets left!");

        _event.ticketsRemaining -= _quantity;
        tickets[msg.sender][_eventId] += _quantity;
    }

    function transferTicket(uint _eventId, uint _quantity, address _to) public {
        require(events[_eventId].date != 0, "Event doesn't exist!");
        require(events[_eventId].date > block.timestamp, "Event has expired!");
        require(tickets[msg.sender][_eventId] > _quantity, "You don't have enough tickets to send!");
        tickets[msg.sender][_eventId] -= _quantity;
        tickets[_to][_eventId] += _quantity;
    }
}