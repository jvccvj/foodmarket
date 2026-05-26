import os
from openhands.sdk import LLM, Agent, Conversation, Tool
from openhands.tools.file_editor import FileEditorTool
from openhands.tools.terminal import TerminalTool

llm = LLM(model=os.getenv("LLM_MODEL", "gpt-5.5"), api_key=os.getenv("LLM_API_KEY"))

agent = Agent(
    llm=llm,
    tools=[Tool(name=FileEditorTool.name), Tool(name=TerminalTool.name)],
    agents_dir=".agents/agents",
)

cwd = "/workspace/project/foodmarket"

# Run both agents in parallel
tasks = [
    ("Update CSV data", "Update the CSV data in index.html to fresh food prices"),
    ("Design chart", "Redesign index.html with fresh food market styling"),
]

for title, message in tasks:
    print(f"\n=== {title} ===")
    conversation = Conversation(agent=agent, workspace=cwd)
    conversation.send_message(message)
    conversation.run()
    print(conversation.messages[-1].content)
