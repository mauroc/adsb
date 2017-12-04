module ReportUtils

  def adsb_loop

    ActiveRecord::Base.logger = nil
    #save_to_log "AisHub update started -------------------------------------",true

    $t1.close if $t1

    $t1 = TCPSocket.new "data.adsbhub.org", 5002

    rep=Report.new
    prev_hex_ident = nil

    while line = $t1.gets
      p line
      ar=line.split(',')

      trans_type = ar[1].to_i
      hex_ident =   ar[4]

      if prev_hex_ident && prev_hex_ident != hex_ident
        p "incomplete report"
        rep = Report.new
        prev_hex_ident = nil
      end

      case trans_type
        when 1
          rep.message_type            = ar[0]
          rep.session_id              = ar[2]
          rep.aircraft_id             = ar[3]
          rep.hex_ident               = hex_ident
          rep.flight_id               = ar[5]
          rep.date_message_generated  = ar[6]
          rep.time_message_generated  = ar[7]
          rep.date_message_logged     = ar[8]
          rep.time_message_logged     = ar[9]
          rep.call_sign               = ar[10]
        when 2
          rep.altitude                = ar[11].to_i
          rep.ground_speed            = ar[12].to_f
          rep.track                   = ar[13].to_f
          rep.latitude                = ar[14].to_f
          rep.longitude               = ar[15].to_f
          rep.is_on_ground            = ar[21]
        when 3
          rep.altitude                = ar[11].to_i
          rep.latitude                = ar[14].to_f
          rep.longitude               = ar[15].to_f
          rep.alert                   = ar[18]
          rep.emergency               = ar[19]
          rep.spi                     = ar[20]
          rep.is_on_ground            = ar[21]
        when 4
          rep.ground_speed            = ar[12].to_f
          rep.track                   = ar[13].to_f
          rep.vertical_rate           = ar[16].to_i
        else
          p 'unrecognized transmission type'
      end

      rep.add_mess(trans_type)

      p rep.messages

      if rep.complete?
        rep.save
        p "saved report #{rep.id}"
        rep = Report.new
        prev_hex_ident = nil
        #byebug
      else
        prev_hex_ident = hex_ident
      end


      #byebug

    end

  end

end