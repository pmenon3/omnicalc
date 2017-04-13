class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================



    @character_count_with_spaces = @text.length

    text_wo_spaces = @text.gsub(" ", "")
    text_wo_linefeed = text_wo_spaces.gsub("\n","")
    text_wo_carriage_return = text_wo_linefeed.gsub("\r", "")
    text_wo_tabs = text_wo_carriage_return.gsub("\t","")

    @character_count_without_spaces = text_wo_tabs.length

    @word_count = @text.split.length

    input_text_downcase = @text.downcase.gsub(/[^a-z ]/, '')

    input_text_split = input_text_downcase.split

    @occurrences = input_text_split.count(@special_word.downcase.gsub(/[^a-z ]/, ''))

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================

    apr_monthly = (@apr/100) / 12

    months = @years * 12

    @monthly_payment = (apr_monthly * @principal) / (1 - (1+apr_monthly)**-months)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = (@ending - @starting)/60
    @hours = ((@ending - @starting)/60)/60
    @days = (((@ending - @starting)/60)/60)/24
    @weeks = ((((@ending - @starting)/60)/60)/24)/7
    @years = ((((@ending - @starting)/60)/60)/24)/365.25

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort
    @count = @numbers.length

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min

    @median = (@sorted_numbers[(@numbers.length - 1)/2] + @sorted_numbers[@numbers.length/2])/2

    @sum = @numbers.sum

    @mean = @numbers.sum / @numbers.length

    variance_array = @numbers.map { |i| (i - (@numbers.sum / @numbers.length))**2}

    @variance = variance_array.sum / @numbers.length

    @standard_deviation = Math.sqrt(@variance)

    unique_values = @numbers.uniq #b

    unique_values_count = unique_values.map {|i| [i, @numbers.count(i)]} #c

    top_unique_values = unique_values_count.sort_by {|_,cnt| -cnt} #d

    ranked_mode_array = top_unique_values.take_while {|_,cnt| cnt == top_unique_values.first.last} #e

    ranked_array = ranked_mode_array.map(&:first) #f

    @mode = ranked_array[0]

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
