class ArticlesController < ApplicationController
	def index
		puts "Articles Controller - index"
		@investments = Investment.order("total_value DESC")
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
	end

	def show 
		@article = Article.find(params[:id])
	end

	def new
		@article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

	def create
	  @article = Article.new(article_params)
	 
	  if @article.save
	    redirect_to @article
	  else
	    render 'new'
	  end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

	private
		def article_params
			params.require(:article).permit(:title, :text)
		end

end
