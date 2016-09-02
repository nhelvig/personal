class InvestmentTrackerController < ApplicationController
	def index
		puts "Investment Tracker Controller - index"
		@investments = Investment.order("total_value DESC")
		Holdings.updateAllHoldings
		Holdings.updateTotals
		@aggregated_totals = Totals.
		  where("total_value > 0").
		  order("date ASC").
		  group("date").
		  select("date, sum(total_value) AS total_value, sum(total_invested) AS total_invested, sum(percentage_change) AS percentage_change")

		totalValue = Array.new
		totalInvested = Array.new
		percentageChange = Array.new
		investmentData = Array.new

		@aggregated_totals.map { |record|
			totalValue.push(Array[record.date.to_time.to_i * 1000, record.total_value.truncate(2).to_f])
			totalInvested.push(Array[record.date.to_time.to_i * 1000, record.total_invested.truncate(2).to_f])
			percentageChange.push(Array[record.date.to_time.to_i * 1000, record.percentage_change.truncate(2).to_f])
		}  

		@investments.map { |investment|
			data = {
                name: investment.symbol,
                y: investment.value
            }
			investmentData.push(data)
		}

		@pieChart = LazyHighCharts::HighChart.new('pie') do |f|
          f.chart(:type => "pie")
          f.title(:text => "Allocations")	
	      f.series(:colorByPoint => true, :name => "Total value", :data => investmentData)
	      f.plotOptions(:pie => {:size => "60%", :allowPointSelect => true, :cursor => "pointer",
	        					 :dataLabels => {:enabled => true}})
	    end 


        @lineChart = LazyHighCharts::HighChart.new('line') do |f|
          f.chart(:zoomType => "x")
          f.title(:text => "Value Over Time")
	      f.xAxis(:type => "datetime")
	      f.series(:type => "area", :name => "Total value", :yAxis => 0, :turboThreshold => 0, :data => totalValue)
	      f.series(:type => "area", :name => "Total invested", :yAxis => 0, :turboThreshold => 0, :data => totalInvested)
	      f.series(:type => "area", :name => "Percentage change", :yAxis => 1, :turboThreshold => 0, :data => percentageChange)
	      f.plotOptions(:area => {:threshold => "null", :lineWidth => 1, :marker => {:radius => 1}}, 
	      				:line => {:dataLabels => {:enabled => true}})
	      f.yAxis [
	        {:title => {:text => "Value ($)"}, :min => 0 },
	        {:title => {:text => "Percentage Change (%)"}, :opposite => true},
	      ]
	    end

	    if @pieChart.nil? || @lineChart.nil?
	    	render 'new'
	    end            
	end

	def show 
	end

	def new
		render 'new'
  	end

  def edit
  end

  def create
  	puts "Creating new transaction..."
  	params[:transaction][:date] = params[:transaction][:date].to_s.gsub(/([0-9]{2})\/([0-9]{2})\/(20[0-9]{2})/, '\3-\1-\2')
  	
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      puts "Transaction saved. Checking if investment exists."
      if Investment.where(:symbol => @transaction.symbol).exists?
      	puts "Investment exists..."
        @investment = Investment.find(@transaction.symbol)
        Holdings.updateQuantityOfStock(@transaction)
      else
      	puts "Investment does not exist. Creating new investment."
        @investment = Investment.build(@transaction)
        if @investment.save
          puts "Investment saved. Updating holdings and totals."
          Holdings.populateHoldings(@transaction)
          Holdings.updateTotals
        else
          raise "NEW INVESTMENT FAILED"
        end
      end
      redirect_to investmentTracker_path
    else
      render 'index'
    end
  end

  def update
   
  end

  def destroy
    puts "Deleting all records!"
    Investment.delete_all
    Totals.delete_all
    Transaction.delete_all
    Holdings.delete_all
    render 'test'
  end

  private
  def transaction_params
    params.require(:transaction).permit(:symbol, :quantity, :price, :action, :commission, :date)
  end

end
