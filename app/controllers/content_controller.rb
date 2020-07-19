class ContentController < ApplicationController
  def index
    query = Content

    if params[:type]
      query = query.where(content_type: params[:type])
    end

    content = query.all.map { |p| self.serialize_content(p) }
    render :json => { items: content, size: content.size }
  end

  private

  def serialize_content(content)
    serialized = {
      id: content.id,
      type: content.content_type,
      title: content.title,
      plot: content.plot,
      creationDate: content.created_at,
    }

    if (content.number)
      serialized[:number] = content.number
    end

    serialized
  end
end
