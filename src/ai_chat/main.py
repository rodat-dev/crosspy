from rich import print
from rich.prompt import Prompt
from rich.panel import Panel
from openai import OpenAI

def main():
    api_key = Prompt.ask("[bold green]Enter your [bold blue]OpenAI API key[/bold blue][/bold green]")
    client = OpenAI(api_key=api_key)

    print(Panel.fit(
        "Welcome to the AI Chat!",
        title="[bold green]AI Chat[/bold green]",
        subtitle="[bold blue]Ask anything you want[/bold blue]",
        border_style="green",
    ))

    messages = [
        {"role": "system", "content": "You are a helpful assistant."},
    ]

    while True:
        user_input = Prompt.ask("[bold blue]You[/bold blue]")
        if user_input.lower() in ["exit", "quit"]:
            print("[bold green]AI:[/bold green] Goodbye!")
            break

        messages.append({"role": "user", "content": user_input})

        response = client.chat.completions.create(
            model="gpt-4o-mini",
            messages=messages,
            max_tokens=100,
            temperature=0.7,
        )

        ai_response = response.choices[0].message.content.strip()
        messages.append({"role": "assistant", "content": ai_response})
        
        print(Panel.fit(
            f"[bold green]AI:[/bold green] {ai_response}",
            title="[bold green]AI[/bold green]",
            border_style="green",
        ))
        
if __name__ == "__main__":
    main()
