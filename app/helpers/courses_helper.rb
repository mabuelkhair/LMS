module CoursesHelper
	def in_course
		ret= (@course.students.include? current_user or @course.owner.id==current_user.id)
	end
end
