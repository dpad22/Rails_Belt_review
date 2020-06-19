Rails.application.routes.draw do

# --------root--------------

root 'sessions#new'


# --------comments-----------

post 'comments/new' => 'comments#create'


# --------attendees-----------

post 'attendees/:id' => 'attendees#create'

delete 'attendees/:id' => 'attendees#destroy'

# --------events------------

get 'events' => 'events#index'

get 'events/:id' => 'events#show'

get 'events/:id/edit' => 'events#edit'

patch 'events/:id' => 'events#update'

post 'events/new' => 'events#create'

delete 'events/:id' => 'events#destroy'

# --------users--------------

get 'users/new' => 'users#new'

post 'users' => 'users#create'

get 'users/:id' => 'users#edit'

patch 'users/:id' => 'users#update'


# --------sessions-----------

get 'sessions/new' => 'sessions#new', as: 'login'

post 'sessions' => 'sessions#create'

get 'sessions/delete' => 'sessions#destroy', as: 'logout'

end
