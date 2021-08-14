help:
	@echo "  Usage:\n    \033[36m make <target>\n\n \033[0m Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "     \033[36m%-30s\033[0m %s\n", $$1, $$2}'

setuptools: ## Install project required tools
	@./Scripts/setup.sh

generate: ## Generate projects, workspace and install pods
	@$(MAKE) clean
	@$(MAKE) generateprojects
	@$(MAKE) cacheApp
	@$(MAKE) installdependencies
	@$(MAKE) open

generateprojects: ## Generate only .xcodeproj projects using Tuist	
	@echo "\n\033[1;36mGenerating Xcode projects\033[0m"
	@(tuist generate)
		
installdependencies: ## Install dependencies and generate workspace
	@echo "\n\033[1;36mRunning bundle install\033[0m"
	@bundle install --quiet

	@echo "\n\033[1;36mInstalling Pods\033[0m"
	@bundle exec pod install || bundle exec pod install --repo-update

template: ## Install and update VIP template to Xcode
	@sh -c "cd Templates/ArchitectureTemplate; swiftc install.swift -o ./install; sudo ./install"
	@rm Templates/ArchitectureTemplate/install

module: ## Create a new module | Usage: `make module name=NewModuleName type=feature hasApi=true`
	@./Scripts/generateModule.sh $(name) $(type) $(hasApi)
	@$(MAKE) generate

feature: ## Create a new feature module | Usage: `make feature name=NewModuleName hasApi=true`
	@$(MAKE) module name=$(name) type=Feature hasApi=$(hasApi)

service: ## Create a new service module | Usage: `make service name=NewModuleName hasApi=true`
	@$(MAKE) module name=$(name) type=Service hasApi=$(hasApi)

helper: ## Create a new helper module | Usage: `make helper name=NewModuleName`
	@$(MAKE) module name=$(name) type=Helper hasApi=false

clean: ## Cleanup projects
	@echo "\n\033[1;33mClosing Xcode...\033[0m"
	-@killall Xcode
	@echo "\033[1;31mRemoving Pods directory...\033[0m"
	-@rm -Rf ./Pods
	@echo "\033[1;31mRemoving workspace...\033[0m"
	-@rm -Rf ./ScalableMonorepo.xcworkspace
	@echo "\033[1;31mRemoving Xcode projects...\033[0m"
	-@rm -Rf ./ScalableMonorepo/ScalableMonorepo.xcodeproj
	-@find Modules -maxdepth 2 -name "*.xcodeproj" -exec rm -r {} \;

cleanall: ## Cleanup projects and pods
	bundle exec pod deintegrate ScalableMonorepo/ScalableMonorepo.xcodeproj
	@$(MAKE) clean
	@git clean -fdx

open: ## Open workspace
	@echo "\n\033[1;32mOpening Xcode!\033[0m"
	@open ./ScalableMonorepo.xcworkspace 

# build: ## Build scheme // make build name=DIService
# 	@$(MAKE) cacheApp
	
# 	@echo "\n\033[1;33mBuilding $(name) with Tuist...\033[0m"
# 	@(tuist build $(name) --verbose)

# buildApp: ## Build app
# # @$(MAKE) cacheApp

# 	@echo "\n\033[1;33mBuilding Scalable Monorepo with Tuist...\033[0m"
# # @(tuist build Scalable\ Monorepo\ -\ Debug)
# 	@(tuist build Scalable\ Monorepo\ -\ Debug --verbose)

cacheApp: ## Cache app
	@echo "\n\033[1;33mCaching Scalable Monorepo with Tuist...\033[0m"
	@(tuist cache warm Scalable\ Monorepo\ -\ Debug)
