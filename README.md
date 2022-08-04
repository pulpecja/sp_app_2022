# sp_app_2022

## Usage

This script receives one argument, which should be the name of the file that contains web logs. Here is the example of the content:
```
/help_page/1 126.318.035.038
/contact 184.123.665.067
/home 184.123.665.067
/contact 184.123.665.067
```
For more examples, please take a look at `webserver.log` file.

To run this script, run `ruby ./parser.rb webserver.log`. You can also use your own file if it's correctly formatted.

Script will return the list of webpages with most views (in descending order) and the list of webpages with most unique views.


## Installation

If you want to install the project, you simply need to run `bundle install`.

## Testing

In order to run test, you need to install the project, and then run `rspec`.
