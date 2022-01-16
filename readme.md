# Rover game

A simple rover game.

## Setup

1. Install dependencies: `% bundle install`
2. Run tests: `% bundle exec rspec`

## Usage

Load the program into an IRB session: `% bin/play`

Once loaded, you can start the game by calling `Rover.play`. This starts a loop
where you can input your commands.

### Moving the rover

The rover must be placed before it can be moved or turned. All commands sent to
it will be ignored until it is placed.

Place the rover with `PLACE x,y,facing`, where `x` and `y` are grid coordinate
values from 0 to 4, and `facing` is a cardinal direction `NORTH, EAST, SOUTH,
WEST`.

Once the rover is placed, it can be:

- moved 1 grid unit in the direction it is facing with the command `MOVE`
- turned to the left or right with the commands `LEFT` or `RIGHT`
- asked to report its current location and facing with `REPORT`
- re-placed with a new `PLACE x,y,facing` command

### Limits of movement

The rover will not make moves that would cause it to "fall off" the grid
coordinate map it knows about (a 5x5 square). If it receives a `MOVE` command
that would cause this, the command will be ignored.

## Design decisions and future possibilities

### `Board` objects

The `Board` class is not strictly speaking necessary at the moment, since the
problem is presented with a 5x5 grid as a constant requirement.

However, it's not hard to imagine the map changing shape, or even having
obstacles in the future.

To this end (and because there's no major complexity added by having a
collaborating board object at this point), I chose to move the question of the
'legality' of a given address into the `Board`.

This means that the `Board` class could expand to have maps other than 5x5
without the rover knowing about it.

We could also easily add obstacle handling, either by renaming the `#in_bounds?`
method to something like `#address_viable?` and updating the implementation to
handle obstacles as well as boundaries, or by adding a second obstacle-specific
method.

### `Runner` testing

The `Runner` class is very lightly tested, despite having the most methods.

The reason for this is that a lot of the tests would just end up testing basic
Ruby functionality like IO.

The tests that exist are limited to "business logic", and ensure that the input
parsing, and especially the more more complex `PLACE` command syntax is
correctly handled.

### Longer-term rover movement

A more interesting problem would be to give the rover a desired ending-address,
and let it figure out how to get there on its own, without constant user input.

This gets difficult if the map also includes obstacles, but the first option
there is to let the rover move itself until it hits an obstacle, then ask for
help. Beyond that I'd have to look into path-finding algorithms (which I'm sure
exist, but have no experience with).

## Plan

- [x] identify core concepts
- [x] begin by speccing core concepts, then implementing
  - board
  - rover and movement
  - runner/control module, with help and report, delegating movement commands to
      rover
- [x] put together game

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
