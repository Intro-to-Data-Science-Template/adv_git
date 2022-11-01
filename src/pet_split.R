# define petsplit function

pet_split = function(pet_vector, possible_columns){
  
  # make a base dataframe with rows for each of our cases.
  pet_output = data.frame(
    "id" = 1:length(pet_vector)
  )
  
  # iterate through all options and create a column with NAs for it
  for(option in possible_columns){
    
    # make a new column with a character version of each possible option.
    pet_output[, as.character(option)] = NA
    
  }
  
  # fill output df
  for(option in possible_columns){
    
    # fill dataframe iterativly.
    pet_output[ , option] = grepl(option, pet_vector, ignore.case = TRUE)
    
  }
  
  # clear all know options
  for(option in possible_columns){
    
    # remove all known options
    pet_vector = gsub(pattern = option, pet_vector, replacement = '', ignore.case = TRUE)
    
  }
  
  # clear commas and whitespace
  pet_vector = gsub(pattern = ',', pet_vector, replacement = '', ignore.case = TRUE)
  pet_vector = trimws(pet_vector)
  
  # Fill in 'other'
  pet_output$other = pet_vector
  # Turn blanks into NAs
  pet_output[pet_output$other == "" & !is.na(pet_output$other), 'other'] = NA
  
  # return output
  return(pet_output)
}