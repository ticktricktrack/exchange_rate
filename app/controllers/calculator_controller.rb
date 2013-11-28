class CalculatorController < ApplicationController
  before_filter :load_exchange_rate_data

  def index

  end

  def convert
    @date = Chronic.parse(params["date"]).to_date
    @from_currency = params["from_currency"]
    @to_currency = params["to_currency"]
    @amount = params["amount"]

    selected_rate = @exchange_rate.at(@date, @from_currency, @to_currency)
    @converted_amount = @amount.to_f * selected_rate
  end

  private

  # Load default data from the RkFxRates Gem
  def load_exchange_rate_data
    @exchange_rate = RkFxRates::ExchangeRate.new
    @currencies = @exchange_rate.available_currencies
    @dates = @exchange_rate.available_dates
  end
end
