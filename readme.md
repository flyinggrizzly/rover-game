# Rover game

## Plan

- [x] identify core concepts
- [ ] begin by speccing core concepts, then implementing
  - board
  - rover and movement
  - runner/control module, with help and report, delegating movement commands to
      rover
- [ ] put together game

## Core classes

### `Board`

- knows its own x-extent and y-extent (hard-coded to 5)
- given an addres `[ x, y ]`, responds whether that address is in or out of
    bounds

### `Rover`

- can be placed
- can be moved (checking whether the move is legal first, by asking the `Board`)
- can be turned

### `Control`

- responsible for initializing all collaborating objects
- responsible for relaying commands to rover
- responsible for humanizing any report information from the rover for the user
