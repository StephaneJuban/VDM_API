module Vdm
  module V1
    module Entities
      class Posts < Grape::Entity
        expose :id
        expose :content
        expose :date
        expose :author
        unexpose :created_at
        unexpose :updated_at
      end
    end

    class Posts < Grape::API
      version 'v1', using: :path
      format :json
      prefix :api

      resource :posts do
        desc "Return list of VDM posts"
        # Get the VDM posts stored in the database
        params do
          optional :from, type: DateTime
          optional :to, type: DateTime
          optional :author, type: String
        end
        get do
          @posts = Post.filter(params)

          present :posts, @posts, :with => Vdm::V1::Entities::Posts
          present :count, @posts.length
        end

        desc "Return a post"
        # Get a specific VDM post
        params do
          requires :id, type: Integer, desc: "Post id"
        end
        route_param :id do
          get do
            @post = Post.find(params[:id])
            present :post, @post, :with => Vdm::V1::Entities::Posts
          end
        end
      end
    end
  end
end