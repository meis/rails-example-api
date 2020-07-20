class ContentController < ApplicationController
  def index
    query = Content
      .eager_load(:episodes, :purchase_options)

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
      purchaseOptions: content.purchase_options.map{ |po| serialize_purchase_option(po) }
    }

    if (content.number)
      serialized[:number] = content.number
    end

    if (content.episodes.size > 0)
      serialized[:episodes] = content.episodes
        .sort_by(&:number)
        .map { |e| serialize_episode(e) }
    end

    serialized
  end

  def serialize_episode(episode)
    {
      id: episode.id,
      number: episode.number,
      title: episode.title,
      plot: episode.plot,
    }
  end

  def serialize_purchase_option(purchase_option)
    {
      price: purchase_option.price,
      quality: purchase_option.quality,
    }
  end
end