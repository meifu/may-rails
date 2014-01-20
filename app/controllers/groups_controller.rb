class GroupsController < ApplicationController

	before_action :login_required, :only => [:new, :create, :edit,:update,:destroy]

	def index
		@groups = Group.all
	end

	def show
		@group = Group.find(params[:id])
		@posts = @group.posts
	end

	def new
		@group = Group.new
	end

	def create
		# @group = Group.new(group_params)
		# @group.save
		
		# redirect_to groups_path

		@group = current_user.groups.build(group_params)
		if @group.save
			redirect_to groups_path
		else
			render :new
		end

	end

	def edit
		# @group = Group.find(params[:id])
		# @post = @group.posts.find(params[:id])

		@group = current_user.groups.find(params[:id])

	end

	def update
		# @group = Group.find(params[:id])
		@group = current_user.groups.find(params[:id])

		if @group.update(group_params)
			redirect_to group_path(@group)
		else
			render :edit
		end
	end

	def destroy
		# @group = Group.find(params[:group_id])
		@group = current_user.groups.find(params[:id])
		# @post = @group.posts.find(params[:id])

		@group.destroy
		# @post.destroy

		redirect_to groups_path
		# redirect_to group_path(@group)
	end


	private

	def group_params	
		params.require(:group).permit(:title, :description)
	end

end
