model modeling_informal_settlement

species male skills: [moving]
{
	home living_place;
	point end_point;
	bool move <- false;
	rgb color <- # darkred;
	string rule;
	list<cell> next_to_street;
	list<pink_cube> pink_collection;
	list<cell> mfc_collection;
	reflex lunch when: count mod (24 * 60) = 14 * 60
	{
		if (flip(lunch_male))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'lunch_rule';
			Square target_square <- one_of(square_collection);
			end_point <- any_location_in(target_square);
			move <- true;
			if (flip(lunch_male))
			{
				pink_collection <- [];
				mfc_collection <- [];
				ask mfc
				{
					bool no_cyan_cube <- true;
					ask cyan_cube
					{
						if (distance_to(self.location, myself.location) <= 2)
						{
							no_cyan_cube <- false;
						}

					}

					if (no_cyan_cube)
					{
						add self to: myself.mfc_collection;
					}

				}

				ask one_of(mfc_collection)
				{
					create pink_cube returns: one_pink_cube
					{
						location <- myself.location;
					}

					myself.pink_collection <- myself.pink_collection union one_pink_cube;
				}

			}

		}

	}

	reflex night when: count mod (24 * 60) = 20 * 60
	{
		if (flip(night_male))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'night_rule';
			end_point <- one_of(total_home_cells).location;
			move <- true;
			if (flip(night_male))
			{
				pink_collection <- [];
				ask next_to_street
				{
					if (self.color = # lightskyblue or self.color = # green)
					{
						create pink_cube returns: each_one
						{
							location <- myself.location;
						}

						myself.pink_collection <- myself.pink_collection union each_one;
					}

				}

			}

		}

	}

	reflex dinner when: count mod (24 * 60) = 18 * 60
	{
		if (flip(dinner_male))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'dinner_rule';
			Square target_square <- one_of(square_collection);
			end_point <- any_location_in(target_square);
			move <- true;
			if (flip(dinner_male))
			{
				pink_collection <- [];
				mfc_collection <- [];
				ask mfc
				{
					bool no_cyan_cube <- true;
					ask cyan_cube
					{
						if (distance_to(self.location, myself.location) <= 2)
						{
							no_cyan_cube <- false;
						}

					}

					if (no_cyan_cube)
					{
						add self to: myself.mfc_collection;
					}

				}

				ask one_of(mfc_collection)
				{
					create pink_cube returns: one_pink_cube
					{
						location <- myself.location;
					}

					myself.pink_collection <- myself.pink_collection union one_pink_cube;
				}

			}

		}

	}

	reflex general when: count mod (24 * 60) = 7 * 60 or count mod (24 * 60) = 16 * 60
	{
		if (flip(general_male))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'general_rule';
			end_point <- one_of(total_home_cells).location;
			move <- true;
		}

	}

	reflex moving when: move = true
	{
		do goto target: end_point;
		if (location = end_point)
		{
			move <- false;
		}

	}

	reflex general_wander when: rule = 'general_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_male_general)
		{
			move <- true;
		}

	}

	reflex lunch_wander when: rule = 'lunch_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_male_lunch)
		{
			move <- true;
		}

	}

	reflex dinner_wander when: rule = 'dinner_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_male_dinner)
		{
			move <- true;
		}

	}

	reflex night_wander when: rule = 'night_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_male_night)
		{
			move <- true;
		}

	}

	aspect base
	{
		draw circle(5.5 # m) color: color depth: 5 # m;
	}

}

species female skills: [moving]
{
	home living_place;
	point end_point;
	bool move <- false;
	rgb color <- # red;
	string rule;
	list<cell> next_to_street;
	list<pink_cube> pink_collection;
	list<cell> mfc_collection;
	reflex lunch when: count mod (24 * 60) = 14 * 60
	{
		if (flip(lunch_female))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'lunch_rule';
			Square target_square <- one_of(square_collection);
			end_point <- any_location_in(target_square);
			move <- true;
			if (flip(lunch_female))
			{
				pink_collection <- [];
				mfc_collection <- [];
				ask mfc
				{
					bool no_cyan_cube <- true;
					ask cyan_cube
					{
						if (distance_to(self.location, myself.location) <= 2)
						{
							no_cyan_cube <- false;
						}

					}

					if (no_cyan_cube)
					{
						add self to: myself.mfc_collection;
					}

				}

				ask one_of(mfc_collection)
				{
					create pink_cube returns: one_pink_cube
					{
						location <- myself.location;
					}

					myself.pink_collection <- myself.pink_collection union one_pink_cube;
				}

			}

		}

	}

	reflex night when: count mod (24 * 60) = 20 * 60
	{
		if (flip(night_female))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'night_rule';
			end_point <- one_of(total_home_cells).location;
			move <- true;
		}

	}

	reflex dinner when: count mod (24 * 60) = 18 * 60
	{
		if (flip(dinner_female))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'dinner_rule';
			Square target_square <- one_of(square_collection);
			end_point <- any_location_in(target_square);
			move <- true;
			if (flip(dinner_female))
			{
				pink_collection <- [];
				mfc_collection <- [];
				ask mfc
				{
					bool no_cyan_cube <- true;
					ask cyan_cube
					{
						if (distance_to(self.location, myself.location) <= 2)
						{
							no_cyan_cube <- false;
						}

					}

					if (no_cyan_cube)
					{
						add self to: myself.mfc_collection;
					}

				}

				ask one_of(mfc_collection)
				{
					create pink_cube returns: one_pink_cube
					{
						location <- myself.location;
					}

					myself.pink_collection <- myself.pink_collection union one_pink_cube;
				}

			}

		}

	}

	reflex general when: count mod (24 * 60) = 7 * 60 or count mod (24 * 60) = 16 * 60
	{
		if (flip(general_female))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'general_rule';
			end_point <- one_of(total_home_cells).location;
			move <- true;
			if (flip(general_female))
			{
				pink_collection <- [];
				ask next_to_street
				{
					create pink_cube returns: each_one
					{
						location <- myself.location;
					}

					myself.pink_collection <- myself.pink_collection union each_one;
				}

			}

		}

	}

	reflex moving when: move = true
	{
		do goto target: end_point;
		if (location = end_point)
		{
			move <- false;
		}

	}

	reflex general_wander when: rule = 'general_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_female_general)
		{
			move <- true;
		}

	}

	reflex lunch_wander when: rule = 'lunch_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_female_lunch)
		{
			move <- true;
		}

	}

	reflex dinner_wander when: rule = 'dinner_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_female_dinner)
		{
			move <- true;
		}

	}

	reflex night_wander when: rule = 'night_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_female_night)
		{
			move <- true;
		}

	}

	aspect base
	{
		draw circle(4.5 # m) color: color depth: 5 # m;
	}

}

species kid skills: [moving]
{
	rgb color <- # fuchsia;
	home living_place;
	point end_point;
	bool move <- false;
	string rule;
	list<cell> next_to_street;
	list<pink_cube> pink_collection;
	list<cell> mfc_collection;
	reflex lunch when: count mod (24 * 60) = 14 * 60
	{
		if (flip(lunch_kid))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'lunch_rule';
			Square target_square <- one_of(square_collection);
			end_point <- any_location_in(target_square);
			move <- true;
			if (flip(lunch_kid))
			{
				pink_collection <- [];
				mfc_collection <- [];
				ask mfc
				{
					bool no_cyan_cube <- true;
					ask cyan_cube
					{
						if (distance_to(self.location, myself.location) <= 2)
						{
							no_cyan_cube <- false;
						}

					}

					if (no_cyan_cube)
					{
						add self to: myself.mfc_collection;
					}

				}

				ask one_of(mfc_collection)
				{
					create pink_cube returns: one_pink_cube
					{
						location <- myself.location;
					}

					myself.pink_collection <- myself.pink_collection union one_pink_cube;
				}

			}

		}

	}

	reflex night when: count mod (24 * 60) = 20 * 60
	{
		if (flip(night_kid))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'night_rule';
			end_point <- one_of(total_home_cells).location;
			move <- true;
		}

	}

	reflex dinner when: count mod (24 * 60) = 18 * 60
	{
		if (flip(dinner_kid))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'dinner_rule';
			Square target_square <- one_of(square_collection);
			end_point <- any_location_in(target_square);
			move <- true;
			if (flip(dinner_kid))
			{
				pink_collection <- [];
				mfc_collection <- [];
				ask mfc
				{
					bool no_cyan_cube <- true;
					ask cyan_cube
					{
						if (distance_to(self.location, myself.location) <= 2)
						{
							no_cyan_cube <- false;
						}

					}

					if (no_cyan_cube)
					{
						add self to: myself.mfc_collection;
					}

				}

				ask one_of(mfc_collection)
				{
					create pink_cube returns: one_pink_cube
					{
						location <- myself.location;
					}

					myself.pink_collection <- myself.pink_collection union one_pink_cube;
				}

			}

		}

	}

	reflex general when: count mod (24 * 60) = 8 * 60 or count mod (24 * 60) = 16 * 60 or count mod (24 * 60) = 13 * 60
	{
		if (flip(general_kid))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'general_rule';
			end_point <- one_of(total_home_cells).location;
			move <- true;
			if (flip(general_kid))
			{
				pink_collection <- [];
				ask next_to_street
				{
					if (self.color = # lightskyblue or self.color = # green)
					{
						create pink_cube returns: each_one
						{
							location <- myself.location;
						}

						myself.pink_collection <- myself.pink_collection union each_one;
					}

				}

			}

		}

	}

	reflex campus when: count mod (24 * 60) = 7 * 60 or count mod (24 * 60) = 12 * 60
	{
		if (flip(school_kid))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'school_rule';
			school target_school <- one_of(school_collection);
			end_point <- any_location_in(target_school);
			move <- true;
		}

	}

	reflex moving when: move = true
	{
		do goto target: end_point;
		if (location = end_point)
		{
			move <- false;
		}

	}

	reflex general_wander when: rule = 'general_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_kid_general)
		{
			move <- true;
		}

	}

	reflex lunch_wander when: rule = 'lunch_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_kid_lunch)
		{
			move <- true;
		}

	}

	reflex dinner_wander when: rule = 'dinner_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_kid_dinner)
		{
			move <- true;
		}

	}

	reflex night_wander when: rule = 'night_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_kid_night)
		{
			move <- true;
		}

	}

	reflex school_wander when: rule = 'school_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_kid_school)
		{
			move <- true;
		}

	}

	aspect base
	{
		draw circle(3.5 # m) color: color depth: 5 # m;
	}

}

species visitor skills: [moving]
{
	rgb color <- # purple;
	home living_place;
	point end_point;
	bool move <- false;
	string rule;
	int current_count <- -100000;
	list<cyan_cube> cyan_collection;
	list<cell> red_collection;
	reflex lunch when: count mod (24 * 60) = 14 * 60
	{
		if (flip(lunch_visitor))
		{
			rule <- 'lunch_rule';
			Square target_square <- one_of(square_collection);
			end_point <- any_location_in(target_square);
			move <- true;
			if (flip(lunch_visitor))
			{
				red_collection <- [];
				cyan_collection <- [];
				ask total_street_cells_near_shops_1
				{
					if (self.color = # red)
					{
						add self to: myself.red_collection;
					}

				}

				ask one_of(red_collection)
				{
					create cyan_cube returns: one_cyan_cube
					{
						location <- myself.location;
					}

					myself.cyan_collection <- one_cyan_cube;
					myself.current_count <- count;
				}

			}

		}

	}

	reflex night when: count mod (24 * 60) = 20 * 60
	{
		if (flip(night_visitor))
		{
			rule <- 'night_rule';
			end_point <- one_of(total_home_cells).location;
			move <- true;
		}

	}

	reflex dinner when: count mod (24 * 60) = 18 * 60
	{
		if (flip(dinner_visitor))
		{
			rule <- 'dinner_rule';
			Square target_square <- one_of(square_collection);
			end_point <- any_location_in(target_square);
			move <- true;
			if (flip(dinner_visitor))
			{
				red_collection <- [];
				cyan_collection <- [];
				ask total_street_cells_near_shops_1
				{
					if (self.color = # red)
					{
						add self to: myself.red_collection;
					}

				}

				ask one_of(red_collection)
				{
					create cyan_cube returns: one_cyan_cube
					{
						location <- myself.location;
					}

					myself.cyan_collection <- one_cyan_cube;
					myself.current_count <- count;
				}

			}

		}

	}

	reflex general when: count mod (24 * 60) = 7 * 60 or count mod (24 * 60) = 16 * 60
	{
		if (flip(general_visitor))
		{
			rule <- 'general_rule';
			end_point <- one_of(total_home_cells).location;
			move <- true;
			if (flip(general_visitor))
			{
				red_collection <- [];
				cyan_collection <- [];
				ask total_street_cells_near_shops_3
				{
					if (self.color = # red)
					{
						add self to: myself.red_collection;
					}

				}

				ask one_of(red_collection)
				{
					create cyan_cube returns: one_cyan_cube
					{
						location <- myself.location;
					}

					myself.cyan_collection <- one_cyan_cube;
					myself.current_count <- count;
				}

			}

		}

	}

	reflex kill_cyan_cube when: length(cyan_collection) != 0 and count = current_count + 30
	{
		ask cyan_collection
		{
			do die;
		}

		current_count <- -10000;
	}

	reflex moving when: move = true
	{
		do goto target: end_point;
		if (location = end_point)
		{
			move <- false;
		}

	}

	reflex general_wander when: rule = 'general_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_visitor_general)
		{
			move <- true;
		}

	}

	reflex lunch_wander when: rule = 'lunch_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_visitor_lunch)
		{
			move <- true;
		}

	}

	reflex dinner_wander when: rule = 'dinner_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_visitor_dinner)
		{
			move <- true;
		}

	}

	reflex night_wander when: rule = 'night_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_visitor_night)
		{
			move <- true;
		}

	}

	aspect base
	{
		draw circle(5.5 # m) color: color depth: 5 # m;
	}

}

species new_male skills: [moving]
{
	rgb color <- # darkred;
	string rule;
	point end_point;
	bool move <- false;
	list<pink_cube> pink_collection;
	list<cell> mfc_collection;
	reflex lunch when: count mod (24 * 60) = 14 * 60
	{
		if (flip(lunch_male))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'lunch_rule';
			Square target_square <- one_of(square_collection);
			end_point <- any_location_in(target_square);
			move <- true;
			if (flip(lunch_male))
			{
				pink_collection <- [];
				mfc_collection <- [];
				ask mfc
				{
					bool no_cyan_cube <- true;
					ask cyan_cube
					{
						if (distance_to(self.location, myself.location) <= 2)
						{
							no_cyan_cube <- false;
						}

					}

					if (no_cyan_cube)
					{
						add self to: myself.mfc_collection;
					}

				}

				ask one_of(mfc_collection)
				{
					create pink_cube returns: one_pink_cube
					{
						location <- myself.location;
					}

					myself.pink_collection <- myself.pink_collection union one_pink_cube;
				}

			}

		}

	}

	reflex night when: count mod (24 * 60) = 20 * 60
	{
		if (flip(night_male))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'night_rule';
			end_point <- one_of(new_home_cube - temp_yellow_cube).location;
			move <- true;
		}

	}

	reflex dinner when: count mod (24 * 60) = 18 * 60
	{
		if (flip(dinner_male))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'dinner_rule';
			Square target_square <- one_of(square_collection);
			end_point <- any_location_in(target_square);
			move <- true;
			if (flip(dinner_male))
			{
				pink_collection <- [];
				mfc_collection <- [];
				ask mfc
				{
					bool no_cyan_cube <- true;
					ask cyan_cube
					{
						if (distance_to(self.location, myself.location) <= 2)
						{
							no_cyan_cube <- false;
						}

					}

					if (no_cyan_cube)
					{
						add self to: myself.mfc_collection;
					}

				}

				ask one_of(mfc_collection)
				{
					create pink_cube returns: one_pink_cube
					{
						location <- myself.location;
					}

					myself.pink_collection <- myself.pink_collection union one_pink_cube;
				}

			}

		}

	}

	reflex general when: count mod (24 * 60) = 7 * 60 or count mod (24 * 60) = 16 * 60
	{
		if (flip(general_male))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'general_rule';
			end_point <- one_of(new_home_cube - temp_yellow_cube).location;
			move <- true;
		}

	}

	reflex moving when: move = true
	{
		do goto target: end_point;
		if (location = end_point)
		{
			move <- false;
		}

	}

	reflex lunch_wander when: rule = 'lunch_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_male_lunch)
		{
			move <- true;
		}

	}

	reflex dinner_wander when: rule = 'dinner_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_male_dinner)
		{
			move <- true;
		}

	}

	aspect base
	{
		draw circle(5.5 # m) color: color depth: 5 # m;
	}

}

species new_female skills: [moving]
{
	rgb color <- # red;
	string rule;
	point end_point;
	bool move <- false;
	list<pink_cube> pink_collection;
	list<cell> mfc_collection;
	reflex lunch when: count mod (24 * 60) = 14 * 60
	{
		if (flip(lunch_female))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'lunch_rule';
			Square target_square <- one_of(square_collection);
			end_point <- any_location_in(target_square);
			move <- true;
			if (flip(lunch_female))
			{
				pink_collection <- [];
				mfc_collection <- [];
				ask mfc
				{
					bool no_cyan_cube <- true;
					ask cyan_cube
					{
						if (distance_to(self.location, myself.location) <= 2)
						{
							no_cyan_cube <- false;
						}

					}

					if (no_cyan_cube)
					{
						add self to: myself.mfc_collection;
					}

				}

				ask one_of(mfc_collection)
				{
					create pink_cube returns: one_pink_cube
					{
						location <- myself.location;
					}

					myself.pink_collection <- myself.pink_collection union one_pink_cube;
				}

			}

		}

	}

	reflex night when: count mod (24 * 60) = 20 * 60
	{
		if (flip(night_female))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'night_rule';
			end_point <- one_of(new_home_cube - temp_yellow_cube).location;
			move <- true;
		}

	}

	reflex dinner when: count mod (24 * 60) = 18 * 60
	{
		if (flip(dinner_female))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'dinner_rule';
			Square target_square <- one_of(square_collection);
			end_point <- any_location_in(target_square);
			move <- true;
			if (flip(dinner_female))
			{
				pink_collection <- [];
				mfc_collection <- [];
				ask mfc
				{
					bool no_cyan_cube <- true;
					ask cyan_cube
					{
						if (distance_to(self.location, myself.location) <= 2)
						{
							no_cyan_cube <- false;
						}

					}

					if (no_cyan_cube)
					{
						add self to: myself.mfc_collection;
					}

				}

				ask one_of(mfc_collection)
				{
					create pink_cube returns: one_pink_cube
					{
						location <- myself.location;
					}

					myself.pink_collection <- myself.pink_collection union one_pink_cube;
				}

			}

		}

	}

	reflex general when: count mod (24 * 60) = 7 * 60 or count mod (24 * 60) = 16 * 60
	{
		if (flip(general_female))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'general_rule';
			end_point <- one_of(new_home_cube - temp_yellow_cube).location;
			move <- true;
		}

	}

	reflex moving when: move = true
	{
		do goto target: end_point;
		if (location = end_point)
		{
			move <- false;
		}

	}

	reflex lunch_wander when: rule = 'lunch_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_female_lunch)
		{
			move <- true;
		}

	}

	reflex dinner_wander when: rule = 'dinner_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_female_dinner)
		{
			move <- true;
		}

	}

	aspect base
	{
		draw circle(4.5 # m) color: color depth: 5 # m;
	}

}

species new_kid skills: [moving]
{
	rgb color <- # fuchsia;
	string rule;
	point end_point;
	bool move <- false;
	list<pink_cube> pink_collection;
	list<cell> mfc_collection;
	reflex lunch when: count mod (24 * 60) = 14 * 60
	{
		if (flip(lunch_kid))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'lunch_rule';
			Square target_square <- one_of(square_collection);
			end_point <- any_location_in(target_square);
			move <- true;
			if (flip(lunch_kid))
			{
				pink_collection <- [];
				mfc_collection <- [];
				ask mfc
				{
					bool no_cyan_cube <- true;
					ask cyan_cube
					{
						if (distance_to(self.location, myself.location) <= 2)
						{
							no_cyan_cube <- false;
						}

					}

					if (no_cyan_cube)
					{
						add self to: myself.mfc_collection;
					}

				}

				ask one_of(mfc_collection)
				{
					create pink_cube returns: one_pink_cube
					{
						location <- myself.location;
					}

					myself.pink_collection <- myself.pink_collection union one_pink_cube;
				}

			}

		}

	}

	reflex night when: count mod (24 * 60) = 20 * 60
	{
		if (flip(night_kid))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'night_rule';
			end_point <- one_of(new_home_cube - temp_yellow_cube).location;
			move <- true;
		}

	}

	reflex dinner when: count mod (24 * 60) = 18 * 60
	{
		if (flip(dinner_kid))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'dinner_rule';
			Square target_square <- one_of(square_collection);
			end_point <- any_location_in(target_square);
			move <- true;
			if (flip(dinner_kid))
			{
				pink_collection <- [];
				mfc_collection <- [];
				ask mfc
				{
					bool no_cyan_cube <- true;
					ask cyan_cube
					{
						if (distance_to(self.location, myself.location) <= 2)
						{
							no_cyan_cube <- false;
						}

					}

					if (no_cyan_cube)
					{
						add self to: myself.mfc_collection;
					}

				}

				ask one_of(mfc_collection)
				{
					create pink_cube returns: one_pink_cube
					{
						location <- myself.location;
					}

					myself.pink_collection <- myself.pink_collection union one_pink_cube;
				}

			}

		}

	}

	reflex general when: count mod (24 * 60) = 8 * 60 or count mod (24 * 60) = 16 * 60 or count mod (24 * 60) = 13 * 60
	{
		if (flip(general_kid))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'general_rule';
			end_point <- one_of(new_home_cube - temp_yellow_cube).location;
			move <- true;
		}

	}

	reflex campus when: count mod (24 * 60) = 7 * 60 or count mod (24 * 60) = 12 * 60
	{
		if (flip(school_kid))
		{
			ask pink_collection
			{
				do die;
			}

			rule <- 'school_rule';
			school target_school <- one_of(school_collection);
			end_point <- any_location_in(target_school);
			move <- true;
		}

	}

	reflex moving when: move = true
	{
		do goto target: end_point;
		if (location = end_point)
		{
			move <- false;
		}

	}

	reflex lunch_wander when: rule = 'lunch_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_kid_lunch)
		{
			move <- true;
		}

	}

	reflex dinner_wander when: rule = 'dinner_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_kid_dinner)
		{
			move <- true;
		}

	}

	reflex school_wander when: rule = 'school_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_kid_school)
		{
			move <- true;
		}

	}

	aspect base
	{
		draw circle(3.5 # m) color: color depth: 5 # m;
	}

}

species new_visitor skills: [moving]
{
	rgb color <- # purple;
	string rule;
	point end_point;
	bool move <- false;
	int current_count <- -100000;
	list<cyan_cube> cyan_collection;
	list<cell> red_collection;
	reflex lunch when: count mod (24 * 60) = 14 * 60
	{
		if (flip(lunch_visitor))
		{
			rule <- 'lunch_rule';
			Square target_square <- one_of(square_collection);
			end_point <- any_location_in(target_square);
			move <- true;
			if (flip(lunch_visitor))
			{
				red_collection <- [];
				cyan_collection <- [];
				ask total_street_cells_near_shops_1
				{
					if (self.color = # red)
					{
						add self to: myself.red_collection;
					}

				}

				ask one_of(red_collection)
				{
					create cyan_cube returns: one_cyan_cube
					{
						location <- myself.location;
					}

					myself.cyan_collection <- one_cyan_cube;
					myself.current_count <- count;
				}

			}

		}

	}

	reflex night when: count mod (24 * 60) = 20 * 60
	{
		if (flip(night_visitor))
		{
			rule <- 'night_rule';
			end_point <- one_of(new_home_cube - temp_yellow_cube).location;
			move <- true;
		}

	}

	reflex dinner when: count mod (24 * 60) = 18 * 60
	{
		if (flip(dinner_visitor))
		{
			rule <- 'dinner_rule';
			Square target_square <- one_of(square_collection);
			end_point <- any_location_in(target_square);
			move <- true;
			if (flip(dinner_visitor))
			{
				red_collection <- [];
				cyan_collection <- [];
				ask total_street_cells_near_shops_1
				{
					if (self.color = # red)
					{
						add self to: myself.red_collection;
					}

				}

				ask one_of(red_collection)
				{
					create cyan_cube returns: one_cyan_cube
					{
						location <- myself.location;
					}

					myself.cyan_collection <- one_cyan_cube;
					myself.current_count <- count;
				}

			}

		}

	}

	reflex general when: count mod (24 * 60) = 7 * 60 or count mod (24 * 60) = 16 * 60
	{
		if (flip(general_visitor))
		{
			rule <- 'general_rule';
			end_point <- one_of(new_home_cube - temp_yellow_cube).location;
			move <- true;
			if (flip(general_visitor))
			{
				red_collection <- [];
				cyan_collection <- [];
				ask total_street_cells_near_shops_3
				{
					if (self.color = # red)
					{
						add self to: myself.red_collection;
					}

				}

				ask one_of(red_collection)
				{
					create cyan_cube returns: one_cyan_cube
					{
						location <- myself.location;
					}

					myself.cyan_collection <- one_cyan_cube;
					myself.current_count <- count;
				}

			}

		}

	}

	reflex kill_cyan_cube when: length(cyan_collection) != 0 and count = current_count + 30
	{
		ask cyan_collection
		{
			do die;
		}

		current_count <- -10000;
	}

	reflex moving when: move = true
	{
		do goto target: end_point;
		if (location = end_point)
		{
			move <- false;
		}

	}

	reflex lunch_wander when: rule = 'lunch_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_visitor_lunch)
		{
			move <- true;
		}

	}

	reflex dinner_wander when: rule = 'dinner_rule' and move = false
	{
		do wander speed: 10.0;
		if (distance_to(end_point, location) > radius_visitor_dinner)
		{
			move <- true;
		}

	}

	aspect base
	{
		draw circle(5.5 # m) color: color depth: 5 # m;
	}

}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
global // initial global parameters and create agents

{
	int test <- 0;
	int count;
	int current_hour <- 0;
	int current_minute;
	string current_minute_string <- '00';
	int current_day <- 1;
	int cell_size <- 25 parameter: 'cell size';
	int home_size <- 12 parameter: 'home size';
	int radius_male_general <- 20 parameter: 'radius male general';
	int radius_male_lunch <- 10 parameter: 'radius male lunch';
	int radius_male_dinner <- 10 parameter: 'radius male dinner';
	int radius_male_night <- 2 parameter: 'radius male night';
	int radius_female_general <- 3 parameter: 'radius female general';
	int radius_female_lunch <- 5 parameter: 'radius female lunch';
	int radius_female_dinner <- 5 parameter: 'radius female dinner';
	int radius_female_night <- 2 parameter: 'radius female night';
	int radius_kid_general <- 10 parameter: 'radius kid general';
	int radius_kid_lunch <- 10 parameter: 'radius kid lunch';
	int radius_kid_dinner <- 10 parameter: 'radius kid dinner';
	int radius_kid_night <- 2 parameter: 'radius kid night';
	int radius_kid_school <- 10 parameter: 'radius kid school';
	int radius_visitor_general <- 20 parameter: 'radius visitor general';
	int radius_visitor_lunch <- 5 parameter: 'radius visitor lunch';
	int radius_visitor_dinner <- 5 parameter: 'radius visitor dinner';
	int radius_visitor_night <- 2 parameter: 'radius visitor night';
	int total_homes;
	float male_per_home <- 1.0 parameter: 'male per home';
	float female_per_home <- 1.0 parameter: 'female per home';
	float kid_per_home <- 1.0 parameter: 'kid per home';
	float visitor_per_home <- 0.25 parameter: 'visitor per home';
	float general_male <- 0.5 parameter: 'x% male affected by general rule';
	float general_female <- 0.5 parameter: 'x% female affected by general rule';
	float general_kid <- 0.3 parameter: 'x% kid affected by general rule';
	float general_visitor <- 0.4 parameter: 'x% visitor affected by general rule';
	float night_male <- 0.9 parameter: 'x% male affected by night rule';
	float night_female <- 0.9 parameter: 'x% female affected by night rule';
	float night_kid <- 0.95 parameter: 'x% kid affected by night rule';
	float night_visitor <- 0.9 parameter: 'x% visitor affected by night rule';
	float school_kid <- 0.3 parameter: 'x% kid affected by school rule';
	float lunch_male <- 0.5 parameter: 'x% male affected by lunch rule';
	float lunch_female <- 0.9 parameter: 'x% female affected by lunch rule';
	float lunch_kid <- 0.5 parameter: 'x% kid affected by lunch rule';
	float lunch_visitor <- 0.9 parameter: 'x% visitor affected by lunch rule';
	float dinner_male <- 0.9 parameter: 'x% male affected by dinner rule';
	float dinner_female <- 0.5 parameter: 'x% female affected by dinner rule';
	float dinner_kid <- 0.3 parameter: 'x% kid affected by dinner rule';
	float dinner_visitor <- 0.4 parameter: 'x% visitor affected by dinner rule';
	int total_male;
	int total_female;
	int total_kid;
	int total_visitor;
	int new_homes <- 0;
	float moving_speed <- 230.0 * 30 # km / # h;
	list<Square> square_collection;
	list<home> home_collection;
	list<street> street_collection;
	list<school> school_collection;
	list<shop> shop_collection;
	list<road> road_collection;
	list<mainroad> mainroad_collection;
	list<cell> total_street_cells;
	list<cell> total_street_cells_near_shops_3;
	list<cell> total_street_cells_near_shops_1;
	list<cell> total_home_cells;
	list<cell> total_shop_cells;
	list<cell> total_mainroad_cells;
	list<cell> total_laneway_cells;
	list<cell> mfc;
	list<pink_cube> temp_pink_cube <- [];
	list<new_home_cube> temp_yellow_cube <- [];
	list<new_shop_cube> temp_blue_cube <- [];
	// the pathway for inputted SHP file
	file blue_shops <- file('../includes/new shp output/shop.shp');
	file yellow_homes <- file('../includes/new shp output/home.shp');
	file bound <- file("../includes/new shp output/road.shp");
	file square_file <- file("../includes/new shp output/square.shp");
	file school_file <- file("../includes/new shp output/school.shp");
	file street_file <- file("../includes/new shp output/street.shp");
	file mainroad_file <- file("../includes/new shp output/mainroad.shp");
	geometry shape <- envelope(bound);
	init
	{
		count <- 0;
		ask cell //inital the neighbour range for each cell

		{
			self.neighbour_1 <- self neighbors_at 1;
			self.neighbour_2 <- self neighbors_at 2;
			self.neighbour_3 <- self neighbors_at 3;
			self.neighbour_5 <- self neighbors_at 5;
			self.neighbour_10 <- self neighbors_at 10;
			self.neighbour_20 <- self neighbors_at 20;
		}

		create home from: yellow_homes;
		home_collection <- list<home> (home);
		create shop from: blue_shops;
		shop_collection <- list<shop> (shop);
		create Square from: square_file;
		square_collection <- list<Square> (Square);
		create school from: school_file;
		school_collection <- list<school> (school);
		create road from: bound;
		road_collection <- list<road> (road);
		create street from: street_file;
		street_collection <- list<street> (street);
		create mainroad from: mainroad_file;
		mainroad_collection <- list<mainroad> (mainroad);
		loop i over: cell
		{
			loop j over: home
			{
				if (i overlaps j)
				{
					add i to: total_home_cells;
					break;
				}

			}

			loop j over: shop
			{
				if (i overlaps j)
				{
					add i to: total_shop_cells;
					break;
				}

			}

			loop j over: mainroad
			{
				if (i overlaps j)
				{
					add i to: total_mainroad_cells;
					break;
				}

			}

			loop j over: street
			{
				if (i overlaps j)
				{
					add i to: total_street_cells;
					break;
				}

			}

			loop j over: road
			{
				if (i overlaps j)
				{
					add i to: total_laneway_cells;
					break;
				}

			}

		}

		ask total_home_cells
		{
			create home_cube
			{
				location <- myself.location;
			}

		}

		ask total_shop_cells
		{
			create shop_cube
			{
				location <- myself.location;
			}

		}

		ask total_street_cells
		{
			ask total_shop_cells
			{
				if (distance_to(self.location, myself.location) <= 3.5)
				{
					add myself to: total_street_cells_near_shops_3;
				}

			}

		}

		ask total_street_cells
		{
			ask total_shop_cells
			{
				if (distance_to(self.location, myself.location) <= 1.5)
				{
					add myself to: total_street_cells_near_shops_1;
				}

			}

		}

		total_homes <- int((length(total_home_cells)) / home_size);
		total_male <- int(total_homes * male_per_home);
		total_female <- int(total_homes * female_per_home);
		total_kid <- int(total_homes * kid_per_home);
		total_visitor <- int(total_homes * visitor_per_home);
		create female number: total_female
		{
			living_place <- one_of(home_collection);
			location <- one_of(total_home_cells).location;
			speed <- moving_speed;
			end_point <- location;
			rule <- 'night_rule';
			list<cell> home_cells <- list<cell> (agents_overlapping(living_place));
			next_to_street <- home_cells inter total_street_cells;
		}

		create male number: total_male
		{
			living_place <- one_of(home_collection);
			location <- one_of(total_home_cells).location;
			speed <- moving_speed;
			end_point <- location;
			rule <- 'night_rule';
			list<cell> home_cells <- list<cell> (agents_overlapping(living_place));
			next_to_street <- home_cells inter total_street_cells;
		}

		create kid number: total_kid
		{
			living_place <- one_of(home_collection);
			location <- one_of(total_home_cells).location;
			speed <- moving_speed;
			end_point <- location;
			rule <- 'night_rule';
			list<cell> home_cells <- list<cell> (agents_overlapping(living_place));
			next_to_street <- home_cells inter total_street_cells;
		}

		create visitor number: total_visitor
		{
			living_place <- one_of(home_collection);
			location <- one_of(total_home_cells).location;
			speed <- moving_speed;
			end_point <- location;
			rule <- 'night_rule';
		}

	}

	int total_people;
	reflex color_update // color changes in street due to the people movement

	{
		mfc <- [];
		ask total_street_cells
		{
			total_people <- 0;
			ask male
			{
				if (self overlaps myself)
				{
					total_people <- total_people + 1;
				}

			}

			ask female
			{
				if (self overlaps myself)
				{
					total_people <- total_people + 1;
				}

			}

			ask kid
			{
				if (self overlaps myself)
				{
					total_people <- total_people + 1;
				}

			}

			if (total_people >= 5)
			{
				add self to: mfc;
			}

			ask visitor
			{
				if (self overlaps myself)
				{
					total_people <- total_people + 1;
				}

			}

			if (total_people = 0)
			{
				color <- # lightskyblue;
			}

			if (total_people = 1)
			{
				color <- # green;
			}

			if (total_people = 2)
			{
				color <- # yellow;
			}

			if (total_people = 3)
			{
				color <- # orange;
			}

			if (total_people >= 4)
			{
				color <- # red;
			}

		}

	}

	reflex kill_temp_pink_cube
	{
		ask temp_pink_cube
		{
			do die;
		}

		temp_pink_cube <- [];
	}

	reflex kill_temp_yellow_cube
	{
		ask temp_yellow_cube
		{
			do die;
		}

		temp_yellow_cube <- [];
	}

	reflex kill_temp_blue_cube
	{
		ask temp_blue_cube
		{
			do die;
		}

		temp_blue_cube <- [];
	}

	reflex general_street_rule when: count mod (24 * 60) >= 7 * 60 and count mod (24 * 60) <= 14 * 60 or count mod (24 * 60) >= 16 * 60 and count mod (24 * 60) <= 18 * 60
	{
		list<cell> ready_to_change <- [];
		ask total_street_cells
		{
			if (self.color = # yellow)
			{
				add self to: ready_to_change;
			}

		}

		loop i over: ready_to_change
		{
			bool grow_pink_cube <- false;
			loop j over: i.neighbour_2
			{
				loop k over: total_home_cells
				{
					if (j = k)
					{
						loop m over: j.neighbour_3
						{
							if (m.color = # lightskyblue)
							{
								if (flip(0.9))
								{
									grow_pink_cube <- true;
								}

								break;
							}

						}

						loop m over: j.neighbour_3
						{
							if (m.color = # red)
							{
								if (flip(0.6))
								{
									grow_pink_cube <- true;
								}

								break;
							}

						}

						break;
					}

				}

			}

			if (grow_pink_cube)
			{
				create pink_cube returns: one_pink_cube
				{
					location <- i.location;
				}

				temp_pink_cube <- temp_pink_cube union one_pink_cube;
			}

		}

	}

	reflex lunch_street_rule when: count mod (24 * 60) >= 14 * 60 and count mod (24 * 60) <= 16 * 60
	{
		list<cell> ready_to_change <- [];
		ask total_street_cells
		{
			if (self.color = # red)
			{
				add self to: ready_to_change;
			}

		}

		loop i over: ready_to_change
		{
			bool grow_pink_cube <- false;
			loop j over: i.neighbour_10
			{
				loop k over: total_home_cells
				{
					if (j = k)
					{
						list<cell> temp <- total_shop_cells inter j.neighbour_10;
						if (length(temp) > 0)
						{
							if (flip(0.9))
							{
								grow_pink_cube <- true;
							}

						}

						break;
					}

				}

			}

			if (grow_pink_cube)
			{
				create pink_cube returns: one_pink_cube
				{
					location <- i.location;
				}

				temp_pink_cube <- temp_pink_cube union one_pink_cube;
			}

		}

	}

	reflex night_shop_to_home_rule when: count mod (24 * 60) >= 20 * 60 or count mod (24 * 60) <= 7 * 60
	{
		loop i over: total_shop_cells
		{
			bool grow_yellow_cube <- false;
			list<cell> temp <- total_home_cells inter i.neighbour_10;
			if (length(temp) > 0)
			{
				loop j over: i.neighbour_10
				{
					if (j.color = # lightskyblue or j.color = # green)
					{
						if (flip(0.7))
						{
							grow_yellow_cube <- true;
						}

						break;
					}

				}

			}

			if (grow_yellow_cube)
			{
				create new_home_cube returns: one_yellow_cube
				{
					location <- i.location;
					level <- 0;
				}

				temp_yellow_cube <- temp_yellow_cube union one_yellow_cube;
			}

		}

	}

	reflex lunch_shop_to_home_rule when: count mod (24 * 60) >= 14 * 60 and count mod (24 * 60) <= 16 * 60
	{
		loop i over: total_shop_cells
		{
			bool grow_yellow_cube <- false;
			list<cell> temp <- i.neighbour_1 inter total_home_cells;
			if (length(temp) > 0)
			{
				if (flip(0.8))
				{
					grow_yellow_cube <- true;
				}

			}

			if (grow_yellow_cube)
			{
				create new_home_cube returns: one_yellow_cube
				{
					location <- i.location;
					level <- 0;
				}

				temp_yellow_cube <- temp_yellow_cube union one_yellow_cube;
			}

		}

	}

	reflex every_4_weeks_shop_to_home_rule when: current_day mod (4 * 7) = 0
	{
		loop i over: total_shop_cells
		{
			bool grow_yellow_cube <- false;
			list<cell> temp <- i.neighbour_3 inter total_mainroad_cells;
			if (length(temp) > 0)
			{
				if (flip(0.9))
				{
					grow_yellow_cube <- true;
				}

			}

			if (grow_yellow_cube)
			{
				create new_home_cube returns: one_yellow_cube
				{
					location <- i.location;
					level <- 0;
				}

				temp_yellow_cube <- temp_yellow_cube union one_yellow_cube;
			}

		}

	}

	reflex every_4_weeks_shop_to_home_red_density_rule when: current_day mod (4 * 7) = 0 //impossible

	{
		loop i over: total_shop_cells
		{
			bool grow_yellow_cube <- false;
			list<cell> temp <- i.neighbour_3 inter total_mainroad_cells;
			if (length(temp) > 0)
			{
				loop j over: one_of(temp).neighbour_10
				{
					if (j.color = # red)
					{
						if (flip(0.7))
						{
							grow_yellow_cube <- true;
						}

						break;
					}

				}

			}

			if (grow_yellow_cube)
			{
				create new_home_cube returns: one_yellow_cube
				{
					location <- i.location;
					level <- 0;
				}

				temp_yellow_cube <- temp_yellow_cube union one_yellow_cube;
			}

		}

	}

	reflex general_home_to_shop_rule when: count mod (24 * 60) >= 7 * 60 and count mod (24 * 60) <= 14 * 60 or count mod (24 * 60) >= 16 * 60 and count mod (24 * 60) <= 18 * 60 //maybe

	{
		loop i over: total_home_cells
		{
			bool grow_blue_cube <- false;
			list<cell> temp <- i.neighbour_10 inter total_mainroad_cells;
			if (length(temp) > 0)
			{
				if (flip(0.8))
				{
					grow_blue_cube <- true;
				}

			}

			if (grow_blue_cube)
			{
				create new_shop_cube returns: one_blue_cube
				{
					location <- i.location;
				}

				temp_blue_cube <- temp_blue_cube union one_blue_cube;
			}

		}

	}

	reflex lunch_home_to_shop_rule when: count mod (24 * 60) >= 14 * 60 and count mod (24 * 60) <= 16 * 60
	{
		loop i over: total_home_cells
		{
			bool grow_blue_cube <- false;
			loop j over: i.neighbour_5
			{
				if (j.color = # orange)
				{
					loop k over: j.neighbour_5
					{
						bool find_pink_cyan <- false;
						loop m over: (pink_cube union cyan_cube)
						{
							if (k overlaps m)
							{
								find_pink_cyan <- true;
								if (flip(0.8))
								{
									grow_blue_cube <- true;
								}

								break;
							}

						}

						if (find_pink_cyan)
						{
							break;
						}

					}

				}

			}

			if (grow_blue_cube)
			{
				create new_shop_cube returns: one_blue_cube
				{
					location <- i.location;
				}

				temp_blue_cube <- temp_blue_cube union one_blue_cube;
			}

		}

	}

	reflex general_home_to_home_level_2_every_4_weeks_rule when: (count mod (24 * 60) >= 7 * 60 and count mod (24 * 60) <= 14 * 60 or count mod (24 * 60) >= 16 * 60 and count mod
	(24 * 60) <= 18 * 60) and (current_day mod (4 * 7) = 0)
	{
		loop i over: total_home_cells
		{
			bool grow_level_2_yellow_cube <- false;
			list<cell> temp <- i.neighbour_20 inter total_mainroad_cells;
			if (length(temp) > 0)
			{
				loop j over: one_of(temp).neighbour_20
				{
					if (j.color = # red)
					{
						if (flip(0.6))
						{
							grow_level_2_yellow_cube <- true;
						}

						break;
					}

				}

			}

			if (grow_level_2_yellow_cube)
			{
				create new_home_cube
				{
					location <- { (i.location.x), (i.location.y), (cell_size * 1) };
					level <- 1;
				}

				create new_home_cube
				{
					location <- { (i.location.x), (i.location.y), (cell_size * 2) };
					level <- 2;
				}

				i.level <- 2;
			}

		}

	}

	reflex general_home_to_home_every_4_weeks_rule when: (count mod (24 * 60) >= 7 * 60 and count mod (24 * 60) <= 14 * 60 or count mod (24 * 60) >= 16 * 60 and count mod
	(24 * 60) <= 18 * 60) and (current_day mod (4 * 7) = 0)
	{
		loop i over: total_home_cells
		{
			bool grow_yellow_cube <- false;
			list<cell> temp <- i.neighbour_3 inter total_shop_cells;
			list<cell> temp_pink_cyan <- [];
			if (length(temp) > 0)
			{
				loop j over: one_of(temp).neighbour_20
				{
					loop k over: (pink_cube union cyan_cube)
					{
						if (j overlaps k)
						{
							add j to: temp_pink_cyan;
						}

					}

				}

			}

			if (length(temp_pink_cyan) > 0)
			{
				loop j over: one_of(temp_pink_cyan).neighbour_20
				{
					if (j.color = # red)
					{
						if (flip(0.7))
						{
							grow_yellow_cube <- true;
						}

						break;
					}

				}

			}

			if (grow_yellow_cube)
			{
				create new_home_cube returns: one_yellow_cube
				{
					location <- i.location;
					level <- 0;
				}

				temp_yellow_cube <- temp_yellow_cube union one_yellow_cube;
			}

		}

	}

	reflex cyan_to_blue_rule when: current_day mod (6 * 7) = 0
	{
		loop i over: cyan_cube
		{
			bool grow_blue <- false;
			cell underneath;
			loop j over: cell
			{
				if (i.location.x = j.location.x and i.location.y = j.location.y)
				{
					underneath <- j;
					break;
				}

			}

			bool no_laneway <- true;
			loop j over: underneath.neighbour_3
			{
				loop k over: road_collection
				{
					if (j overlaps k)
					{
						no_laneway <- false;
						break;
					}

				}

				if (no_laneway = false)
				{
					break;
				}

			}

			if (no_laneway)
			{
				loop j over: underneath.neighbour_2
				{
					if (j.color = # red)
					{
						if (flip(0.5))
						{
							grow_blue <- true;
						}

						break;
					}

				}

			}

			if (grow_blue)
			{
				create new_shop_cube
				{
					location <- underneath.location;
				}

			}

		}

	}

	reflex pink_to_yellow_rule when: current_day mod (4 * 7) = 0
	{
		loop i over: pink_cube
		{
			bool grow_yellow <- false;
			cell underneath;
			loop j over: cell
			{
				if (i.location.x = j.location.x and i.location.y = j.location.y)
				{
					underneath <- j;
					break;
				}

			}

			bool no_laneway <- true;
			loop j over: underneath.neighbour_2
			{
				loop k over: road_collection
				{
					if (j overlaps k)
					{
						no_laneway <- false;
						break;
					}

				}

				if (no_laneway = false)
				{
					break;
				}

			}

			if (no_laneway)
			{
				loop j over: underneath.neighbour_2
				{
					if (j.color = # green or j.color = # lightskyblue)
					{
						if (flip(0.5))
						{
							grow_yellow <- true;
						}

						break;
					}

				}

			}

			if (grow_yellow)
			{
				create new_home_cube
				{
					location <- underneath.location;
					level <- 0;
				}

			}

		}

	}

	reflex every_1_week_yellow_grow_level_1 when: current_day mod (1 * 7) = 0
	{
		loop i over: total_home_cells
		{
			bool can_build <- true;
			bool grow_up <- false;
			if (i.level != 0)
			{
				can_build <- false;
			}

			bool no_laneway <- true;
			loop j over: i.neighbour_2
			{
				loop k over: road_collection
				{
					if (j overlaps k)
					{
						no_laneway <- false;
						break;
					}

				}

				if (no_laneway = false)
				{
					break;
				}

			}

			if (no_laneway)
			{
				loop j over: i.neighbour_2
				{
					if (j.color = # green or j.color = # lightskyblue)
					{
						if (flip(0.8))
						{
							grow_up <- true;
						}

						break;
					}

				}

			}

			if (can_build and grow_up)
			{
				create new_home_cube
				{
					location <- { (i.location.x), (i.location.y), (cell_size * 1) };
					level <- 1;
				}

				i.level <- 1;
			}

		}

	}

	reflex every_1_week_yellow_grow_level_2 when: current_day mod (1 * 7) = 0
	{
		loop i over: total_home_cells
		{
			bool can_build <- true;
			bool grow_up <- false;
			if (i.level != 1)
			{
				can_build <- false;
			}

			bool no_laneway <- true;
			loop j over: i.neighbour_2
			{
				loop k over: road_collection
				{
					if (j overlaps k)
					{
						no_laneway <- false;
						break;
					}

				}

				if (no_laneway = false)
				{
					break;
				}

			}

			if (no_laneway)
			{
				loop j over: i.neighbour_2
				{
					if (j.color = # green)
					{
						if (flip(0.8))
						{
							grow_up <- true;
						}

						break;
					}

				}

			}

			if (can_build and grow_up)
			{
				create new_home_cube
				{
					location <- { (i.location.x), (i.location.y), (cell_size * 2) };
					level <- 2;
				}

				i.level <- 2;
			}

		}

	}

	reflex every_1_week_yellow_grow_level_3 when: current_day mod (1 * 7) = 0
	{
		loop i over: total_home_cells
		{
			bool can_build <- true;
			bool grow_up <- false;
			if (i.level != 2)
			{
				can_build <- false;
			}

			bool no_laneway <- true;
			loop j over: i.neighbour_2
			{
				loop k over: road_collection
				{
					if (j overlaps k)
					{
						no_laneway <- false;
						break;
					}

				}

				if (no_laneway = false)
				{
					break;
				}

			}

			if (no_laneway)
			{
				loop j over: i.neighbour_2
				{
					if (j.color = # green)
					{
						if (flip(0.8))
						{
							grow_up <- true;
						}

						break;
					}

				}

			}

			if (can_build and grow_up)
			{
				create new_home_cube
				{
					location <- { (i.location.x), (i.location.y), (cell_size * 3) };
					level <- 3;
				}

				i.level <- 3;
			}

		}

	}

	reflex every_1_week_yellow_grow_level_1_on_blue when: current_day mod (1 * 7) = 0
	{
		loop i over: total_shop_cells
		{
			bool can_build <- true;
			bool grow_up <- false;
			if (i.level != 0)
			{
				can_build <- false;
			}

			bool no_mainroad <- true;
			loop j over: i.neighbour_10
			{
				loop k over: mainroad_collection
				{
					if (j overlaps k)
					{
						no_mainroad <- false;
						break;
					}

				}

				if (no_mainroad = false)
				{
					break;
				}

			}

			if (no_mainroad)
			{
				if (flip(0.8))
				{
					grow_up <- true;
				}

			}

			if (can_build and grow_up)
			{
				create new_home_cube
				{
					location <- { (i.location.x), (i.location.y), (cell_size * 1) };
					level <- 1;
				}

				i.level <- 1;
			}

		}

	}

	reflex every_1_week_yellow_grow_level_2_on_blue when: current_day mod (1 * 7) = 0
	{
		loop i over: total_shop_cells
		{
			bool can_build <- true;
			bool grow_up <- false;
			if (i.level != 1)
			{
				can_build <- false;
			}

			bool no_mainroad <- true;
			bool no_laneway <- true;
			loop j over: i.neighbour_10
			{
				loop k over: mainroad_collection
				{
					if (j overlaps k)
					{
						no_mainroad <- false;
						break;
					}

				}

				if (no_mainroad = false)
				{
					break;
				}

				loop k over: road_collection
				{
					if (j overlaps k)
					{
						no_laneway <- false;
						break;
					}

				}

				if (no_laneway = false)
				{
					break;
				}

			}

			if (no_mainroad and no_laneway)
			{
				loop j over: i.neighbour_2
				{
					if (j.color = # red)
					{
						if (flip(0.8))
						{
							grow_up <- true;
						}

						break;
					}

				}

			}

			if (can_build and grow_up)
			{
				create new_home_cube
				{
					location <- { (i.location.x), (i.location.y), (cell_size * 2) };
					level <- 2;
				}

				i.level <- 2;
			}

		}

	}

	reflex every_1_week_yellow_grow_level_3_on_blue when: current_day mod (1 * 7) = 0
	{
		loop i over: total_shop_cells
		{
			bool can_build <- true;
			bool grow_up <- false;
			if (i.level != 2)
			{
				can_build <- false;
			}

			bool no_mainroad <- true;
			bool no_laneway <- true;
			loop j over: i.neighbour_10
			{
				loop k over: mainroad_collection
				{
					if (j overlaps k)
					{
						no_mainroad <- false;
						break;
					}

				}

				if (no_mainroad = false)
				{
					break;
				}

				loop k over: road_collection
				{
					if (j overlaps k)
					{
						no_laneway <- false;
						break;
					}

				}

				if (no_laneway = false)
				{
					break;
				}

			}

			if (no_mainroad and no_laneway)
			{
				loop j over: i.neighbour_2
				{
					if (j.color = # red)
					{
						if (flip(0.8))
						{
							grow_up <- true;
						}

						break;
					}

				}

			}

			if (can_build and grow_up)
			{
				create new_home_cube
				{
					location <- { (i.location.x), (i.location.y), (cell_size * 3) };
					level <- 3;
				}

				i.level <- 3;
			}

		}

	}

	reflex every_1_week_yellow_grow_level_4_on_blue when: current_day mod (1 * 7) = 0
	{
		loop i over: total_shop_cells
		{
			bool can_build <- true;
			bool grow_up <- false;
			if (i.level != 3)
			{
				can_build <- false;
			}

			bool no_mainroad <- true;
			loop j over: i.neighbour_10
			{
				loop k over: mainroad_collection
				{
					if (j overlaps k)
					{
						no_mainroad <- false;
						break;
					}

				}

				if (no_mainroad = false)
				{
					break;
				}

			}

			if (no_mainroad)
			{
				if (flip(0.8))
				{
					grow_up <- true;
				}

			}

			if (can_build and grow_up)
			{
				create new_home_cube
				{
					location <- { (i.location.x), (i.location.y), (cell_size * 4) };
					level <- 4;
				}

				i.level <- 4;
			}

		}

	}

	reflex every_1_week_yellow_grow_level_5_on_blue when: current_day mod (1 * 7) = 0
	{
		loop i over: total_shop_cells
		{
			bool can_build <- true;
			bool grow_up <- false;
			if (i.level != 4)
			{
				can_build <- false;
			}

			bool no_mainroad <- true;
			loop j over: i.neighbour_10
			{
				loop k over: mainroad_collection
				{
					if (j overlaps k)
					{
						no_mainroad <- false;
						break;
					}

				}

				if (no_mainroad = false)
				{
					break;
				}

			}

			if (no_mainroad)
			{
				if (flip(0.8))
				{
					grow_up <- true;
				}

			}

			if (can_build and grow_up)
			{
				create new_home_cube
				{
					location <- { (i.location.x), (i.location.y), (cell_size * 5) };
					level <- 5;
				}

				i.level <- 5;
			}

		}

	}

	reflex generate_new_population
	{
		int current_new_homes <- length(new_home_cube) - length(temp_yellow_cube);
		current_new_homes <- int(current_new_homes / home_size);
		int new_build_homes <- current_new_homes - new_homes;
		if (new_build_homes > 0)
		{
			new_homes <- current_new_homes;
			create new_male number: new_build_homes * male_per_home
			{
				location <- one_of(new_home_cube - temp_yellow_cube).location;
				speed <- moving_speed;
				end_point <- location;
				rule <- 'night_rule';
			}

			create new_female number: new_build_homes * female_per_home
			{
				location <- one_of(new_home_cube - temp_yellow_cube).location;
				speed <- moving_speed;
				end_point <- location;
				rule <- 'night_rule';
			}

			create new_kid number: new_build_homes * kid_per_home
			{
				location <- one_of(new_home_cube - temp_yellow_cube).location;
				speed <- moving_speed;
				end_point <- location;
				rule <- 'night_rule';
			}

			create new_visitor number: new_build_homes * visitor_per_home
			{
				location <- one_of(new_home_cube - temp_yellow_cube).location;
				speed <- moving_speed;
				end_point <- location;
				rule <- 'night_rule';
			}

		}

	}

	reflex save_result // save the out put into result file

	{
		int yellow <- 0;
		int blue <- 0;
		int pink <- 0;
		int cyan <- 0;
		int grey <- 0;
		int black <- 0;
		int green <- 0;
		int laneway <- 0;
		black <- length(total_mainroad_cells);
		loop i over: total_street_cells
		{
			if (i.color = # green)
			{
				green <- green + 1;
			}

		}

		cyan <- length(cyan_cube);
		pink <- length(pink_cube);
		grey <- length(total_street_cells) - length(cyan_cube) - length(temp_pink_cube);
		blue <- length(shop_cube) + length(new_shop_cube) - length(temp_yellow_cube);
		yellow <- length(home_cube) + length(new_home_cube) - length(temp_blue_cube);
		laneway <- length(total_laneway_cells);
		int yellow0 <- 0;
		int yellow1 <- 0;
		int yellow2 <- 0;
		int yellow3 <- 0;
		int yellow4 <- 0;
		int yellow5 <- 0;
		loop i over: new_home_cube
		{
			if (i.level = 1)
			{
				yellow1 <- yellow1 + 1;
			}

			if (i.level = 2)
			{
				yellow2 <- yellow2 + 1;
			}

			if (i.level = 3)
			{
				yellow3 <- yellow3 + 1;
			}

			if (i.level = 4)
			{
				yellow4 <- yellow4 + 1;
			}

			if (i.level = 5)
			{
				yellow5 <- yellow5 + 1;
			}

		}

		yellow0 <- yellow - (yellow1 + yellow2 + yellow3 + yellow4 + yellow5);
		save
		("current_day: " + current_day + " current_time: " + string(current_hour) + ':' + current_minute_string + " pink: " + pink + " cyan: " + cyan + " blue: " + blue + " yellow: " + yellow + " yellow0: " + yellow0 + " yellow1: " + yellow1 + " yellow2: " + yellow2 + " yellow3: " + yellow3 + " yellow4: " + yellow4 + " yellow5: " + yellow5 + " grey: " + grey + " green: " + green + " black: " + black + " laneway: " + laneway)
		to: "../result/data.txt" type: "text" rewrite: false;// ".../result " is the destination for the output file. "data.txt" is the output file name.
	}

	reflex addcount // control one iteration time

	{
		count <- count + 30;
		current_hour <- int(count / 60) mod 24;
		current_minute <- count mod 60;
		if (current_minute = 30)
		{
			current_minute_string <- '30';
		} else
		{
			current_minute_string <- '00';
		}

		current_day <- int(count / 1440) + 1;
	}

}

species shop
{
	float height <- 1 # m;
	aspect geom
	{
		draw shape color: # blue depth: height;
	}

}

species home
{
	float height <- 1 # m;
	aspect geom
	{
		draw shape color: # yellow depth: height;
	}

}

species mainroad
{
	float height <- 1 # m;
	aspect geom
	{
		draw shape color: # black depth: height;
	}

}

species road
{
	geometry display_shape <- shape + 2.0;
	aspect geom
	{
		draw display_shape color: # lightgrey depth: 1.0;
	}

}

species street
{
	float height <- 1 # m;
	aspect geom
	{
		draw shape color: # cyan depth: height;
	}

}

species Square
{
	float height <- 20 # m;
	aspect geom
	{
		draw shape color: # beige depth: height;
	}

}

species school
{
	float height <- 1 # m;
	aspect geom
	{
		draw shape color: # olive depth: height;
	}

}

species pink_cube
{
	aspect geom
	{
		draw cube(cell_size) color: # pink;
	}

}

species cyan_cube
{
	aspect geom
	{
		draw cube(cell_size + 1) color: # cyan;
	}

}

species shop_cube
{
	aspect geom
	{
		draw cube(cell_size) color: # blue;
	}

}

species home_cube
{
	aspect geom
	{
		draw cube(cell_size) color: # yellow;
	}

}

species new_shop_cube
{
	aspect geom
	{
		draw cube(cell_size) color: # blue;
	}

}

species new_home_cube
{
	int level;
	aspect geom
	{
		draw cube(cell_size) color: # yellow;
	}

}

grid cell cell_width: cell_size cell_height: cell_size neighbors: 8
{
	rgb color;
	int level <- 0;
	list<cell> neighbour_1;
	list<cell> neighbour_2;
	list<cell> neighbour_3;
	list<cell> neighbour_5;
	list<cell> neighbour_10;
	list<cell> neighbour_20;
}

experiment shop_and_house type: gui
{
	parameter "Shapefile for the roads:" var: bound category: "GIS";
	output
	{
		display map_3D type: opengl ambient_light: 120 synchronized: true
		{
			grid cell;
			species road aspect: geom refresh: true;
			species home aspect: geom refresh: true;
			species shop aspect: geom refresh: true;
			species new_shop_cube aspect: geom refresh: true;
			species new_home_cube aspect: geom refresh: true;
			species Square aspect: geom refresh: true;
			species school aspect: geom refresh: true;
			species mainroad aspect: geom refresh: true;
			species pink_cube aspect: geom refresh: true;
			species cyan_cube aspect: geom refresh: true;
			species male aspect: base;
			species kid aspect: base;
			species visitor aspect: base;
			species female aspect: base;
			species new_male aspect: base;
			species new_kid aspect: base;
			species new_visitor aspect: base;
			species new_female aspect: base;
			graphics 'current time'
			{
				draw string(current_hour) + ':' + current_minute_string at: { 800, 800 } color: # black font: font("Helvetica", 45, # plain);
				draw 'Day' + string(current_day) at: { 800, 400 } color: # black font: font("Helvetica", 35, # plain);

				//draw string(test) at: { 800,1500 } color: # black font: font("Helvetica", 35 , #plain);
			}

		}
		// the line chart ouput for the this model 

		//        display pink_chart
		//        {
		//        	chart "number of pink_cube " type: series x_label: "Time" x_serie_labels: string(current_hour) + ':' + current_minute_string y_label: 'Number of pink_cube'
		//        	{
		//        		data "pink_cube" value: length(pink_cube);
		//        	}
		//        }
		//
		//        display cyan_chart
		//        {
		//        	chart "number of cyan_cube" type: series x_label: "Time" x_serie_labels: string(current_hour) + ':' + current_minute_string y_label: 'Number of cyan_cube'
		//        	{
		//        		data "cyan_cube" value: length(cyan_cube) color: # blue;
		//        	}
		//        }
		//
		//        display my_chart
		//        {
		//        	chart "number of cyan_cube and number of pink_cube" type: series x_label: "Time" x_serie_labels: string(current_hour) + ':' + current_minute_string y_label: 'Number of cube'
		//        	{
		//        		data "pink_cibe" value: length(pink_cube);
		//        		data "cyan_cube" value: length(cyan_cube);
		//        	}
		//        }
	}

}
