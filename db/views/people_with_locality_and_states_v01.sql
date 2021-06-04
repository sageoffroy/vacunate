SELECT  
	"localities"."name" as locality_name, 
	"people"."dni", 
	"people"."population_group", 
	"people"."priority", 
	"people"."firstname", 
	"people"."lastname", 
	"people"."dni_sex",
	"people"."birthdate",
	"people"."phone_code",
	"people"."phone",
	"people"."email",
	"states"."name" as state_name,
	"people"."obesity",
	"people"."diabetes",
	"people"."chronic_kidney_disease",
  "people"."cardiovascular_disease",
  "people"."chronic_lung_disease",
  "people"."inmunocompromised",
  "people"."created_at",
  "people"."updated_at"

FROM 
	"people" 
		INNER JOIN "localities" ON "localities"."id" = "people"."locality_id" 
		INNER JOIN "states" ON "states"."id" = "people"."state_id"