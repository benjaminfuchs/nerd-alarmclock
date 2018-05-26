<!--
# ----------------------------------------------------------------------------
# Webinterface for the nerd-alarmclock.
#
# This file defines the content area for the alarm-configuration.
#
# Author: Bernhard Bablok, Benjamin Fuchs
# License: GPL3
#
# Website: https://github.com/bablokb/nerd-alarmclock
#
# ----------------------------------------------------------------------------
-->

<!-- helper scripts   --------------------------------------------------   -->

<script  type="text/javascript">

  // add event-listeners
  $(document).ready(function() {
    $('#id_alarm_nr').on('change',on_alarm_nr_changed);
    $('#id_alarm_state').on('click',on_toggle_alarm_state);
  });

  // read alarm-data from server
  function read_alarm_settings() {
    $.ajax({
      url: "/alarms/read"
    }).then(function(data) {
      nclock.alarms = data;
      on_alarm_nr_changed();
    });
  };

  // hook to run when tab is selected
  function on_select_tab_alarm() {
    if (!nclock.hasOwnProperty("alarms")) {
      nclock.alarm_nr = 1;
      read_alarm_settings();
    } else {
      on_alarm_nr_changed();
    }
  };

  // fill select-tag with options (triggered from main.tpl)
  function alarm_fill_lists(data) {
    fill_list(data.led_alarms,$('#id_alarm_led_name'));
    fill_list(data.display_alarms,$('#id_alarm_display_name'));
    fill_list(data.sound_alarms,$('#id_alarm_sound_name'));
  };

  // event-handler if alarm-number changes
  function on_alarm_nr_changed(event) {
    if (event) {
      nclock.alarm_nr = $(event.target).val();
    }
    // update values in form
    var data = nclock.alarms[nclock.alarm_nr-1];
    set_value(data);
  };

  // event-handler to change alarm-state
  function on_toggle_alarm_state(event) {
    if ($(event.target).val() === 'enabled') {
      $(event.target).val('disabled');
      $(event.target).removeClass("w3-border-blue w3-text-blue");
      $(event.target).addClass("w3-border-red w3-text-red");
    } else {
      $(event.target).val('enabled');
      $(event.target).addClass("w3-border-blue w3-text-blue");
      $(event.target).removeClass("w3-border-red w3-text-red");
    }
  };
</script>

<!-- form for alarm settings   -----------------------------------------   -->

<div id="id_content_alarm" class="content">
  <form id="id_form_alarm" method="post"
        class="w3-container w3-card-4 w3-light-grey w3-text-blue w3-margin">

      <!-- alarm-selection ----------------------------------------------- -->
      <div class="w3-row-padding w3-section">
        <label for="id_alarm_nr" class="w3-col l1">Nr</label>
        <!-- TODO: implement on_alarm_nr_select() -->
        <select class="w3-select w3-col l1" id="id_alarm_nr">
           <option value="1">1</option>
           <option value="2">2</option>
           <option value="3">3</option>
           <option value="4">4</option>
        </select>
        <label for="id_alarm_name" class="w3-col l1">Name</label>
        <input type="text" class="w3-input w3-col l4" id="id_alarm_name"/>
      </div>

      <!-- state --------------------------------------------------------- -->
      <div class="w3-row-padding w3-section">
        <label for="id_alarm_state" class="w3-col l1">State</label>
        <input type="button" id="id_alarm_state"
               class="w3-col l1 w3-button w3-round-xxlarge
               w3-border w3-border-blue"
               value="enabled" name="alarm_state"/>
      </div>

      <!-- time ---------------------------------------------------------- -->
      <div class="">
        <label for="id_alarm_time" class="w3-col l1">Time</label>
        <input type="time" class="w3-input" id="id_alarm_time"/>
      </div>

      <!-- snooze -------------------------------------------------------- -->
      <div class="">
        <label for="id_alarm_snooze" class="w3-col l1">Snooze</label>
        <input type="time" class="w3-input" id="id_alarm_snooze"/>
      </div>

      <!-- days ---------------------------------------------------------- -->
      <div class="">
        <label for="id_alarm_days" class="w3-col l1">Days</label>
        <!-- TODO: fill select for days -->
        <select class="w3-select" id="id_alarm_days"></select>
      </div>

      <!-- LED (name, duration, delay) ----------------------------------- -->
      <fieldset>
        <legend>LED-Alarm</legend>
        <div class="">
          <label for="id_alarm_led_name" class="w3-col l1">Name</label>
          <select class="w3-select" id="id_alarm_led_name"></select>
        </div>
        <div class="">
          <label for="id_alarm_led_duration" class="w3-col l1">Duration</label>
          <input type="time" class="w3-input" id="id_alarm_led_duration"/>
        </div>
        <div class="">
          <label for="id_alarm_led_delay" class="w3-col l1">Delay</label>
          <input type="time" class="w3-input" id="id_alarm_led_delay"/>
        </div>
      </fieldset>

      <!-- display (name, text, duration, delay) ------------------------- -->
      <fieldset>
        <legend>Display-Alarm</legend>
        <div class="">
          <label for="id_alarm_display_name" class="w3-col l1">Name</label>
          <select class="w3-select" id="id_alarm_display_name"></select>
        </div>
        <div class="">
          <label for="id_alarm_display_text" class="w3-col l1">Text</label>
          <input type="text" class="w3-input" id="id_alarm_display_text"/>
        </div>
        <div class="">
          <label for="id_alarm_display_duration" class="w3-col l1">Duration</label>
          <input type="time" class="w3-input" id="id_alarm_display_duration"/>
        </div>
        <div class="">
          <label for="id_alarm_display_delay" class="w3-col l1">Delay</label>
          <input type="time" class="w3-input" id="id_alarm_display_delay"/>
        </div>
      </fieldset>

      <!-- sound (name, duration, delay, volume) ------------------------- -->
      <fieldset>
        <legend>Sound-Alarm</legend>
        <div class="">
          <label for="id_alarm_sound_name" class="w3-col l1">Name</label>
          <select class="w3-select" id="id_alarm_sound_name"></select>
        </div>
        <div class="">
          <label for="id_alarm_sound_duration" class="w3-col l1">Duration</label>
          <input type="time" class="w3-input" id="id_alarm_sound_duration"/>
        </div>
        <div class="">
          <label for="id_alarm_sound_delay" class="w3-col l1">Delay</label>
          <input type="time" class="w3-input" id="id_alarm_sound_delay"/>
        </div>
        <div class="">
          <label for="id_alarm_sound_fadein" class="w3-col l1">Fadein</label>
          <input type="time" class="w3-input" id="id_alarm_sound_fadein"/>
        </div>
        <div class="">
          <label for="id_alarm_sound_volume" class="w3-col l1">Volume</label>
          <input type="number" class="w3-input" id="id_alarm_sound_volume"/>
        </div>
      </fieldset>

    <div class="w3-section padding-top">
      <button type="submit" class="w3-button w3-round-xxlarge
               w3-border w3-border-blue">Save</button>
    </div>
  </form>
</div>
