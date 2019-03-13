# task-tracker

HW06/HW07 for CS 4550 Web Development

Design choices made (HW07):

* Managers may only assign tasks to their direct underlings, not the underlings of their underlings
  * Validation performed in backend, enforced in frontend by only showing direct underlings of current user in assignee dropdown on task edit form
* Only the manager of the user assigned to a task may change who the task is assigned to; either to one of their underlings or to no one
  * If a task is assigned to someone who is not a direct underling of the current logged in user, the current logged in user can only change fields of the task that are not the assignee.
* A user may only have one manager, a manager may have multiple underlings
* Users are not required to have a manager
* Only users with the "admin" flag set to "true" are considered managers and have underlings, and only users with the admin flag set to true can be set as someone else's manager
  * Validation performed in backend, enforced in frontend by only showing managers in manager dropdown on user edit form
* A user may be their own manager
* A user is assigned a manager from the "edit user" screen
* A task may have many one or more time blocks associated with it, each of which have a start and stop time
* Time blocks have a start date, start time, end date, and end time
  * The start date and start time must occur before the end date and end time, eg: a vaid pair may have a start date/time of March 3 2019, 10:30am and an end date/time of March 3 2019, 10:45am
  * This validation is performed in the backend, and error messages are rendered as an alert in the front end with the appropriate error message
* Users may either manually create a new time block by entering their start date, start time, end date, and end time, or use the "start working" functionality to create a time block with the current time. 
  * The user clicks the "Start working" button, and the current date/time will populate the start time/date table cell in the last row. When finished, they can click the "Stop working" button, which will populate the current date/time in the stop date/time table cell, and they can either click "Clear" to clear the time block or click "Create new" to create a new time block. The user may also click "Clear" at any time in the process to clear an in-progress time block, such as after hitting start but before hitting stop.

------

Design choices made (HW06):

* If users are not logged in they can select the "create account" button in the navbar to create a new user. When they are logged in the navbar instead displays "My account" which is the show page for that user, from where they can edit their user details
* No direct link to user index page (ie: page to list all users), although enforcing users only being able to see/edit their own account details is not implemented
* All tasks are shown on the main application index page, and "back" links on task-related pages direct to the main application index rather than a separate tasks index page
* To assign a task to a user, there is a dropdown menu in the task form that queries all users in the database
* Validation on time spent is done in both the front end and the back end
    * front end: number input has steps of 15 and a minimum of 4
    * back end: changeset function validates that input is at least 0 and a multiple of 15, otherwise returns an error which will be rendered as a flash in the front end
* Tasks are not required to be assigned to a user; if there is no user assigned the "assigned" column will instead display "No user assigned"
* Task description is not shown on index page listing all tasks, and only on show/details page for individual tasks
* Task details including completion can only be set/edited from edit form
* Relation b/w users and tasks is one to many where a task is assigned to a single user and a user may be assigned multiple tasks; the on-delete behavior is set to nilify, meaning if a user is deleted then any tasks assigned to them are instead set to "No user assigned". 

------

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
