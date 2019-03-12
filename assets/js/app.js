import css from "../css/app.scss";

import "phoenix_html"

import jQuery from 'jquery';

window.jQuery = window.$ = jQuery;
import "bootstrap";

import _ from "lodash";

$(function () {
    $(".save-time-block-button").click(function (event) {
        let timeBlockId = $(event.target).data("time-block-id");
        let timeBlock = {
            "id": timeBlockId,
            "start_date": $("#start-date-" + timeBlockId).val(),
            "start_time": $("#start-time-" + timeBlockId).val() + ".000000",
            "stop_date": $("#stop-date-" + timeBlockId).val(),
            "stop_time": $("#stop-time-" + timeBlockId).val() + ".000000",
        };

        let timeBlockPath = "/ajax/time_block/" + timeBlockId;
        $.ajax(timeBlockPath, {
            method: "PUT",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            data: JSON.stringify({
                "id": timeBlockId,
                "time_block": timeBlock
            }),
            success: function (response) {
                console.log(response.data);
                // let data = response.data;
                // $("#start-date-" + timeBlockId).val(data.stop_date);
            }
        });
    });
});