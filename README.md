# Mat Flashcards&Sentences app
## tl;dr
- Ruby on Rails backend (hosted on Fly.io) and React frontend (hosted on netlify.com)
- Backend:
  - https://mat-flashcards.fly.dev
  - Gitgub repo: <a href='https://github.com/mat-jar/mat-flashcards-api'>mat_flashcards_api</a>
  - RoR: api, CanCanCan, Devise, jwt, Warden (custom strategy), has_secure_token, enum, service objects, query objects, httparty, Nokogiri, web scraping, xpath, custom validation, PostgreSQL, polymorphic associations, self joins, Rspec
- Frontend:
  - https://mat-flashcards.netlify.app
  - Gitgub repo: <a href='https://github.com/mat-jar/mat-flashcards-front'>mat-flashcards-front</a>
  - React: class and function components, useState, useEffect, conditional render, axios, runtimeEnv, bootstrap, react-bootstrap, custom css, react-toastify, localStorage, backend authorisation with request headers

## About
Mat Flashcards&Sentences is a prototype educational app creatively based on cram.com and quizlet.com services, as well as Sentence Master Android App, which I used to utilize in my work as an English teacher. My intention was to combine the most valuable features of each of them while adding a few new ideas. <br />

I strongly believe that using flashcards is one of the best ways of memorizing various types of information and a crucial tool when learning languages. Learning the vocabulary usage seems to be an obvious further step, that's why I decided to include a functionality to study complete sentences. <br />

The main goal of developing the project has been to practise building a functional web app, however I really appreciated the notion of creating a potentially useful educative tool.


## Details
The app consists of RoR backend and React frontend working separately, communicating via http requests.
### RoR backend main features:
-	Basic user interface (registration, login, modifying personal data) - user account enables creating their own flashcard/sentence sets, modifying existing ones (with “shared” flag) and displaying basic statistics.
-	Unlogged users can study “shared” flashcard/sentence sets, logged users can open their own flashcard/sentence sets as well.
-	User roles (student, teacher, admin) distinguish possible actions in the app. Admin role users can manage all the resources in the app except for statistics. Users with a teacher role can share specific flashcard/sentence sets with their students (“class” sets) and see their learning statistics. A teacher can be associated with the user during registration thanks to a token pointing to a specific teacher. A teacher can generate multiple unique and one-off tokens and distribute them to their students.
-	A user can add a new flashcard/sentence set or modify an existing one. A single flashcard/sentence can be added or modified as well. Users can have two types of flashcard/sentence sets: “personal”  (seen only by the owners) and “shared” (seen by all logged and unlogged users). A teacher can add “class” flashcard/sentence sets which can be seen by their students.
-	Apart from creating their own sentences, sentences can be scrapped from several leading online dictionaries. When accessed for the first time (database query return empty array) the whole dictionary entries are loaded using httparty and parsed with Nokogiri. Then the sentences are saved in the database and can be fetched with the minimal waiting time.
