$('.payment_form_container').empty()

$('.payment_form_container').append """

    <h2>Check availability</h2>
    <%= form_for(@event, url: events_create_event_and_book_path, html: { class: 'form-horizontal', id: 'create_event_form'}, method: 'post') do |f| %>
                    
      <div class="form-group">
        <label for="date" class="col-sm-2 control-label">Date:</label>
        <div class="col-sm-10">
          <input name="event[date]" type="text" id='location_only_datepicker' placeholder='Click to select date' class="1payment_choice_date_picker" >
        </div>
      </div> <!-- end of form-group -->
    
      
      <div class="row">
        <div class="col-xs-6">
          <div class='form-group'>
            <%= label_tag 'start_time', 'Start-time:', class: 'col-sm-2 control-label' %>
            <div class="col-sm-10">
              <%= f.time_select :start_time,
                    {
                      :combined => true,
                      :default => Time.now.change(:hour => 11, :min => 30),
                      :minute_interval => 30,
                      :time_separator => "",
                      :start_hour => 10,
                      :start_minute => 30,
                      :end_hour => 14,
                      :end_minute => 30
                    },
                    
                    { class: 'form-control' }
                  %>
            </div> <!-- end of col-sm-8 -->
          </div> <!-- end of form-group -->
        </div>

        <div class="col-xs-6">
          <div class="form-group">
            <%= label_tag 'end_time', 'End-time:', class: 'col-sm-2 control-label' %>
            <div class="col-sm-10">
              <%= f.time_select :end_time,
                            {
                              :combined => true,
                              :default => Time.now.change(:hour => 12, :min => 30),
                              :minute_interval => 30,
                              :time_separator => "",
                              :start_hour => 10,
                              :start_minute => 30,
                              :end_hour => 14,
                              :end_minute => 30
                            },
                            { class: 'form-control'}
                          %>
            </div> <!-- end of col-sm-10 -->
          </div> <!-- end of form-group -->
        </div>
      </div>
      
        
      <div class="row">
        <div class="checkbox pull-left col-xs-6">                    
          <label>
            <%= check_box_tag 'Multiple', 'true' %>Block booking
          </label>
          

        </div> <!-- end of checkbox -->
        <div class="col-xs-6">
          <%= select_tag "booking_length", options_for_select((2..52)),include_blank: 'no of weeks?', id: 'no_of_weeks',class: 'form-control select-error' %>
        </div>
      </div>
        <br>

      <div class="form-group">
        <div class="col-sm-offset-2 col-sm-10">
          <%= submit_tag 'Check availability', id: 'event_submit', class: 'btn btn-success' %>
        </div> <!-- end of col-sm-10 -->
      </div> <!-- end of form-group  -->
      <%= hidden_field_tag 'event[subject_id]', @subject_id %>
      <%= hidden_field_tag 'event[teacher_id]', @teacher.id %>
      <%= hidden_field_tag 'event[student_id]', current_teacher.id if teacher_signed_in? %>
      <%= hidden_field_tag 'event[rate]', @rate.first.price %>
    <% end %> <!-- end of form_tag  -->



    """