module CoursesHelper
	def in_course
		if current_user then
			ret= (@course.students.include? current_user or @course.owner.id==current_user.id)
		else
			ret=false
		end
		ret
	end
	def is_public
		  if @course.privacy=="public" then
		  	return true
		  else
		  	return false
		  end
	end
	def is_requested_before
		if JoinRequest.where(:course_id => @course.id , :requester_id => current_user.id).count==0 then
         	return false
        else
        	return true
        end

	end
end
