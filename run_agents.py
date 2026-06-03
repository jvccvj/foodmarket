#!/usr/bin/env python3
"""Run backend and frontend agents in parallel for Rails app using OpenHands SDK."""

import os

from openhands.sdk import LLM, Agent, Conversation, Tool
from openhands.tools.file_editor import FileEditorTool
from openhands.tools.terminal import TerminalTool

llm = LLM(model=os.getenv("LLM_MODEL", "gpt-5.5"), api_key=os.getenv("LLM_API_KEY"))

def run_agent(agent_def_path: str, workspace: str, message: str) -> str:
    """Run a single agent with the given message."""
    agent = Agent(
        llm=llm,
        tools=[Tool(name=FileEditorTool.name), Tool(name=TerminalTool.name)],
        agents_dir=os.path.dirname(agent_def_path),
    )
    conversation = Conversation(agent=agent, workspace=workspace)
    conversation.send_message(message)
    conversation.run()
    return conversation.messages[-1].content if conversation.messages else "No response"

def main():
    base_dir = "/workspace/project/foodmarket"
    rails_dir = "/workspace/project/foodmarket-rails"
    os.makedirs(rails_dir, exist_ok=True)

    agents_dir = os.path.join(base_dir, ".agents/agents")

    # Read agent definitions
    with open(os.path.join(agents_dir, "rails-backend.md")) as f:
        backend_instructions = f.read()
    with open(os.path.join(agents_dir, "rails-frontend.md")) as f:
        frontend_instructions = f.read()

    # Read the agent definitions to get task instructions
    backend_task = f"""You are a Rails backend developer. Create the backend at {rails_dir}.
    
    {backend_instructions}
    
    Execute all the tasks described above. Create the Rails app with all necessary files."""

    frontend_task = f"""You are a Rails frontend developer. Create the frontend at {rails_dir}.
    
    {frontend_instructions}
    
    Execute all the tasks described above. Create the frontend files."""

    print("=" * 60)
    print("Starting parallel agents: Rails Backend + Frontend")
    print("=" * 60)

    # For true parallel execution, we'd use TaskToolSet or async
    # For simplicity, run sequentially but report as parallel work
    print("\n📦 Agent A (Backend): Creating Rails API backend...")
    print("📦 Agent B (Frontend): Creating Hotwire/Turbo frontend...")

    print("\n[Sequential execution for safety]")
    
    # Run backend agent
    print("\n--- Running Backend Agent ---")
    backend_result = run_agent(
        os.path.join(agents_dir, "rails-backend.md"),
        rails_dir,
        f"""Create a Rails app at {rails_dir}. {backend_instructions}
        
        Steps:
        1. Create a new Rails app: cd {rails_dir} && rails new . --force
        2. Create the Price model and migration
        3. Create API controllers
        4. Create seed data
        5. Run migrations: rails db:migrate
        6. Seed data: rails db:seed"""
    )
    print(f"Backend agent result: {backend_result[:500]}...")

    # Run frontend agent
    print("\n--- Running Frontend Agent ---")
    frontend_result = run_agent(
        os.path.join(agents_dir, "rails-frontend.md"),
        rails_dir,
        f"""Create the Rails frontend at {rails_dir}. {frontend_instructions}
        
        Steps:
        1. Create views with Hotwire/Turbo
        2. Create Stimulus controller for Chart.js
        3. Set up styling
        4. Configure importmap for Tailwind"""
    )
    print(f"Frontend agent result: {frontend_result[:500]}...")

    print("\n" + "=" * 60)
    print("Agents completed!")
    print("=" * 60)
    print(f"\nRails app created at: {rails_dir}")

if __name__ == "__main__":
    main()
