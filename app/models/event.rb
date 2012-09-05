class Event < ActiveRecord::Base
  attr_accessible :name, :description, :meridian_indicator, :google_maps_url, :group_url, :date_string, :duration, :start_time_string
  attr_accessor :date_string, :meridian_indicator, :duration, :google_maps_url, :group_url, :start_time_string

  before_save :save_dates

  def name
    return read_attribute(:name)
  end

  def name=(string)
    write_attribute(:name, string)
  end

  def description
    return read_attribute(:description)
  end

  def description=(string)
    write_attribute(:description, string)
  end

  def google_maps_url
    return read_attribute(:google_maps_url)
  end

  def google_maps_url=(string)
    write_attribute(:google_maps_url, string)
  end

  def group_url
    return read_attribute(:group_url)
  end

  def group_url=(string)
    write_attribute(:group_url, string)
  end

  def starting_date
    return DateTime.strptime("#{date_string} #{start_time_string} #{meridian_indicator}", "%Y-%m-%d %l:%M %P")
  end

  def ending_date
    return starting_date + form_entered_time_to_seconds(duration)
  end

  private
    def form_entered_time_to_seconds form_entered_time
      hours_and_minutes = form_entered_time.split(':')
      one_minute = (1.0/(24*60))
      return (hours_and_minutes[0].to_i * 60 * one_minute) + (hours_and_minutes[1].to_i * one_minute)
    end
  
    def save_dates
      write_attribute(:date, starting_date)
      write_attribute(:end_date, ending_date)
      write_attribute(:name, name)
      write_attribute(:description, description)
      write_attribute(:google_maps_url, google_maps_url)
      write_attribute(:group_url, group_url)
    end
end
