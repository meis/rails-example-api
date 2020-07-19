Content.create([
  { content_type: :movie, title: 'Avatar', plot: 'Good movie', created_at: Date.parse('2009-12-10') },
  { content_type: :movie, title: 'Titanic', plot: 'Good movie', created_at: Date.parse('1997-11-18') },
  { content_type: :movie, title: 'The Avengers', plot: 'Good movie', created_at: Date.parse('2012-04-25') },
  { content_type: :movie, title: 'Jurassic World', plot: 'Good movie', created_at: Date.parse('2015-06-09') },
  { content_type: :movie, title: 'Furious 7', plot: 'Good movie', created_at: Date.parse('2015-04-01') },
  { content_type: :movie, title: 'Avengers: Age of Ultron', plot: 'Good movie', created_at: Date.parse('2015-04-22') },
  { content_type: :movie, title: 'Frozen', plot: 'Good movie', created_at: Date.parse('2013-11-27') },
  { content_type: :movie, title: 'Iron Man 3', plot: 'Good movie', created_at: Date.parse('2013-04-18') },
  { content_type: :movie, title: 'Minions', plot: 'Good movie', created_at: Date.parse('2015-06-17') },
  { content_type: :movie, title: 'Captain America: Civil War', plot: 'Good movie', created_at: Date.parse('2016-04-27') },
  { content_type: :movie, title: 'Transformers: Dark of the Moon', plot: 'Good movie', created_at: Date.parse('2011-06-28') },
  { content_type: :movie, title: 'The Lord of the Rings: The Return of the King', plot: 'Good movie', created_at: Date.parse('2003-12-01') },
  { content_type: :movie, title: 'Skyfall', plot: 'Good movie', created_at: Date.parse('2012-10-25') },
  { content_type: :movie, title: 'Transformers: Age of Extinction', plot: 'Good movie', created_at: Date.parse('2014-06-25') },
  { content_type: :movie, title: 'The Dark Knight Rises', plot: 'Good movie', created_at: Date.parse('2012-07-16') },
  { content_type: :movie, title: 'Toy Story 3', plot: 'Good movie', created_at: Date.parse('2010-06-16') },
  { content_type: :movie, title: 'Pirates of the Caribbean: Dead Man’s Chest', plot: 'Good movie', created_at: Date.parse('2006-06-20') },
  { content_type: :movie, title: 'Pirates of the Caribbean: On Stranger Tides', plot: 'Good movie', created_at: Date.parse('2011-05-14') },
  { content_type: :movie, title: 'Alice in Wonderland', plot: 'Good movie', created_at: Date.parse('2010-03-03') },
  { content_type: :movie, title: 'The Hobbit: An Unexpected Journey', plot: 'Good movie', created_at: Date.parse('2012-11-26') },

  { content_type: :season, title: 'Sherlock', number: 1, plot: 'Good season', created_at: Date.parse('2010-07-25') },
  { content_type: :season, title: 'Sherlock', number: 2, plot: 'Good season', created_at: Date.parse('2012-01-01') },
  { content_type: :season, title: 'Sherlock', number: 3, plot: 'Good season', created_at: Date.parse('2014-01-01') },
  { content_type: :season, title: 'Sherlock', number: 4, plot: 'Good season', created_at: Date.parse('2017-01-01') },
])

Episode.create([
  { content_id: Content.find_by(title: 'Sherlock', number: 1).id, title: 'A Study in Pink', number: 1, plot: 'Good episode' },
  { content_id: Content.find_by(title: 'Sherlock', number: 1).id, title: 'The Blind Banker', number: 2, plot: 'Good episode' },
  { content_id: Content.find_by(title: 'Sherlock', number: 1).id, title: 'The Great Game', number: 3, plot: 'Good episode' },
  { content_id: Content.find_by(title: 'Sherlock', number: 2).id, title: 'The Reichenbach Fall', number: 3, plot: 'Good episode' },
  { content_id: Content.find_by(title: 'Sherlock', number: 2).id, title: 'The Hounds of Baskerville', number: 2, plot: 'Good episode' },
  { content_id: Content.find_by(title: 'Sherlock', number: 2).id, title: 'A Scandal in Belgravia', number: 1, plot: 'Good episode' },
  { content_id: Content.find_by(title: 'Sherlock', number: 4).id, title: 'The Six Thatchers', number: 1, plot: 'Good episode' },
  { content_id: Content.find_by(title: 'Sherlock', number: 4).id, title: 'The Lying Detective', number: 2, plot: 'Good episode' },
  { content_id: Content.find_by(title: 'Sherlock', number: 4).id, title: 'The Final Problem', number: 3, plot: 'Good episode' },
  { content_id: Content.find_by(title: 'Sherlock', number: 3).id, title: 'The Empty Hearse', number: 1, plot: 'Good episode' },
  { content_id: Content.find_by(title: 'Sherlock', number: 3).id, title: 'The Sign of Three', number: 2, plot: 'Good episode' },
  { content_id: Content.find_by(title: 'Sherlock', number: 3).id, title: 'His Last Vow', number: 3, plot: 'Good episode' },
])

User.create([
  { email: 'user1@example.com' },
  { email: 'user2@example.com' },
])