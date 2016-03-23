class CategoriesController < ApplicationController
  def show
    #@category = Category.find_by(name: params[:name])
    @category = "festivals"
  end
end

# <div class="container-fluid">
#   <div class="row">
#     <%= 11.times do %>
#       <div class="col-xs-12 col-sm-6 col-md-4 product-div">
#         <div class="row sm-product-row product-row">
#           <div class="col-xs-12">
#             <%= link_to image_tag('http://mortenbentzon.com/wp-content/uploads/2014/07/midnightsun_blog161-e1406761557421.jpg', class: "img-responsive event-image"), '#' %>
#             <div class="sm-product-info">
#               <h4>Sun Festival, Lima Peru</h4>
#               <p>August 14</p>
#               <%= link_to "View Event", '#' %>
#             </div>
#           </div>
#           </div>
#         </div>
#         <div class="row xs-product-row product-row">
#           <div class="col-xs-6">
#             <%= link_to image_tag('http://mortenbentzon.com/wp-content/uploads/2014/07/midnightsun_blog161-e1406761557421.jpg', class: "img-responsive event-image"), '#' %>
#             <div class="sm-product-info">
#               <h4>Sun Festival, Lima Peru</h4>
#               <p>August 14</p>
#               <%= link_to "View Event", '#' %>
#             </div>
#           </div>
#         </div>
#       </div>
#     <% end %>
#   </div>
# </div>
