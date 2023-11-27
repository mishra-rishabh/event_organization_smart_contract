# Event Organizer Smart Contract

## Overview
The **EventOrganizer** smart contract is written in the Solidity programming language for the Ethereum blockchain. It facilitates the creation, purchase, and transfer of tickets for events. The contract allows users to create events, buy tickets for those events, and transfer tickets to other Ethereum addresses.

## Features
### Event Creation
Users can create events by calling the `createEvent` function. The parameters include the name of the event, date, ticket price, and the total number of tickets available for the event. Events are identified by a unique identifier `(eventId)`, which is automatically assigned and incremented with each event creation.

### Event Structure
The `Event` structure holds information about each event, including:
* **Organizer:** The Ethereum address of the person organizing the event.
* **Name:** The name of the event.
* **Date:** The date of the event (in Unix timestamp format).
* **Price:** The price of a single ticket for the event.
* **TicketCount:** The total number of tickets available for the event.
* **TicketsRemaining:** The number of tickets still available for purchase.

### Ticket Purchase
Users can buy tickets for a specific event by calling the `buyTickets` function. This function requires the `eventId` and the desired quantity of tickets as parameters. Users must send Ether (ETH) equal to the total cost of the purchased tickets. The contract ensures that the event exists, is in the future, there are enough tickets available, and the sent Ether is correct.

### Ticket Transfer
Users can transfer their purchased tickets to another Ethereum address by calling the `transferTicket` function. This function requires the `eventId`, the quantity of tickets to transfer, and the recipient's Ethereum address. The contract checks that the event exists, the sender has enough tickets to transfer, and performs the transfer.

## Important Notes
* Events cannot be created with a date earlier than the current timestamp.
* Tickets cannot be purchased for events that have already occurred.
* The `buyTickets` and `transferTicket` functions have validations to ensure correct usage and prevent unauthorized actions.

