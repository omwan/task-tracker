import css from "../css/app.scss";

import "phoenix_html"

import jQuery from 'jquery';

window.jQuery = window.$ = jQuery;
import "bootstrap";

import _ from "lodash";

import moment from "moment";

$(function () {

    //referenced from
    //https://github.com/omwan/latest-additions/blob/master/src/main/resources/static/js/controller.js
    let formatString = function (template, replacements) {
        let replaceFunction = function (match, number) {
            if (typeof replacements[number] !== 'undefined') {
                return replacements[number];
            } else {
                return match;
            }
        };

        return template.replace(/{(\d+)}/g, replaceFunction);
    };

    let timeBlockPath = "/ajax/time_block/";

    let saveOnClick = function (event) {
        let timeBlockId = $(event.target).data("time-block-id");
        let timeBlock = {
            "id": timeBlockId,
            "start_date": $("#start-date-" + timeBlockId).val(),
            "start_time": $("#start-time-" + timeBlockId).val(),
            "stop_date": $("#stop-date-" + timeBlockId).val(),
            "stop_time": $("#stop-time-" + timeBlockId).val(),
        };

        $.ajax(timeBlockPath + timeBlockId, {
            method: "PUT",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: JSON.stringify({
                "id": timeBlockId,
                "time_block": timeBlock
            }),
            success: function (response) {
                console.log(response.data);
            }
        });
    };

    let deleteOnClick = function (event) {
        let timeBlockId = $(event.target).data("time-block-id");
        let tr = $(this).closest('tr');

        let val = confirm("Are you sure?");

        if (val) {
            $.ajax(timeBlockPath + timeBlockId, {
                method: "DELETE",
                dataType: "json",
                contentType: "application/json; charset=UTF-8",
                data: "",
                success: function (response) {
                    tr.remove();
                }
            });
        }
    };

    let clearOnClick = function () {
        let inputs = ["#new-start-date", "#new-start-time", "#new-stop-date", "#new-stop-time"]
        inputs.forEach(function (name) {
            $(name).val("");
        });
    };


    let newRow = '<tr class="time-block-row form-container">\n' +
        '                    <td class="form-group">\n' +
        '                        <input class="form-control" type="date"\n' +
        '                               value="{0}"\n' +
        '                               id="start-date-{1} %>">\n' +
        '                        <input class="form-control" type="time"\n' +
        '                               value="{2}"\n' +
        '                               id="start-time-{1}">\n' +
        '                    </td>\n' +
        '                    <td class="form-group">\n' +
        '                        <input class="form-control" type="date"\n' +
        '                               value="{3}"\n' +
        '                               id="stop-date-{1}}">\n' +
        '                        <input class="form-control" type="time"\n' +
        '                               value="{4}"\n' +
        '                               id="stop-time-{1}">\n' +
        '                    </td>\n' +
        '                    <td class="form-group submit-buttons text-right">\n' +
        '                        <span>\n' +
        '                            <button class="btn btn-primary btn-xs save-time-block-button"\n' +
        '                                    data-time-block-id="{1}">Save</button>\n' +
        '                        </span>\n' +
        '                        <span>\n' +
        '                            <button class="btn btn-danger btn-xs delete-time-block-button"\n' +
        '                                    data-time-block-id="{1}">\n' +
        '                                Delete\n' +
        '                            </button>\n' +
        '                        </span>\n' +
        '                    </td>\n' +
        '                </tr>';

    $(".save-time-block-button").click(saveOnClick);
    $(".delete-time-block-button").click(deleteOnClick);
    $(".clear-time-block-button").click(clearOnClick);

    $(".new-time-block-button").click(function (event) {
        let taskId = $(event.target).data("task-id");

        let timeBlock = {
            "start_date": $("#new-start-date").val(),
            "start_time": $("#new-start-time").val(),
            "stop_date": $("#new-stop-date").val(),
            "stop_time": $("#new-stop-time").val(),
            "task_id": taskId
        };

        $.ajax(timeBlockPath, {
            method: "POST",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: JSON.stringify({"time_block": timeBlock}),
            success: function (response) {
                let data = response.data;
                $(".new-time-block").before(formatString(newRow, [data.start_date,
                    data.id, data.start_time, data.stop_date, data.stop_time]));

                //add button click events to newly created table row
                $(".save-time-block-button").each(function (index) {
                    $(this).unbind('click');
                    $(this).click(saveOnClick);
                });
                $(".delete-time-block-button").each(function (index) {
                    $(this).unbind('click');
                    $(this).click(deleteOnClick);
                });

                clearOnClick();
            }
        });
    });

    let getCurrentDateTime = function () {
        let date = new Date();
        return {
            "date": moment(date).format('YYYY-MM-DD'),
            "time": moment(date).format('HH:mm:ss')
        }
    };


    let manualTimeBlock = {};
    $(".manual-time-block-button").click(function (event) {
        let button = $(this);
        let taskId = $(this).data("task-id");
        if (button.text() === "Start") {
            let start = getCurrentDateTime();
            manualTimeBlock["start_date"] = start.date;
            manualTimeBlock["start_time"] = start.time;

            let startInfo = "<li>Start Date: {0}</li><li>Start Time: {1}</li>";
            $(".manual-start").append(formatString(startInfo, [start.date, start.time]));

            button.text("Stop");
        } else if (button.text() === "Stop") {
            let stop = getCurrentDateTime();
            manualTimeBlock["stop_date"] = stop.date;
            manualTimeBlock["stop_time"] = stop.time;

            let stopInfo = "<li>Stop Date: {0}</li><li>Stop Time: {1}</li>";
            $(".manual-stop").append(formatString(stopInfo, [stop.date, stop.time]));

            button.text("Save");
        } else {
            manualTimeBlock["task_id"] = taskId;
            $.ajax(timeBlockPath, {
                method: "POST",
                dataType: "json",
                contentType: "application/json; charset=UTF-8",
                data: JSON.stringify({"time_block": manualTimeBlock}),
                success: function (response) {
                    let data = response.data;
                    $(".new-time-block").before(formatString(newRow, [data.start_date,
                        data.id, data.start_time, data.stop_date, data.stop_time]));

                    button.text("Start");
                    manualTimeBlock = {};
                    $(".manual-start").text("");
                    $(".manual-stop").text("");
                }
            });
        }
    });

    $(".clear-manual-time-block-button").click(function (event) {
        $(".manual-time-block-button").text("Start");
        $(".manual-start").text("");
        $(".manual-stop").text("");
        manualTimeBlock = {};
    });
});