module Vdm
  class Base < Grape::API
    mount Vdm::V1::Posts
  end
end