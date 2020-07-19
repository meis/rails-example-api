class ContentController < ApplicationController
  def index
    query = Content
      .eager_load(:episodes)

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
end