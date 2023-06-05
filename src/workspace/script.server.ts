import { getChild } from "shared/module";

const Players = game.GetService("Players");

const List = new Set();
const ConnectedList: Map<string, number> = new Map();
const ListCollector: Set<string> = new Set();

const Lasers = getChild("Lasers");
const Bankkey = getChild("BankKey");
const MoneyKey = getChild("MoneyKey");
const Door = getChild("Door");
const Collector = getChild("Collector");

const newPosition = new Vector3(110.5, 32.098, 38.17);

if (Collector && Collector.IsA("Part")) {
	Collector.Touched.Connect((otherPart) => {
		const Humanoid = otherPart.Parent?.FindFirstChildOfClass("Humanoid");

		if (Humanoid && Humanoid.Parent) {
			const key = Humanoid.Parent.Name;
			const Player = Players.FindFirstChild(key);

			if (Player?.IsA("Player")) {
				const Guis = Player.WaitForChild("PlayerGui");
				const Screen = Guis?.WaitForChild("Money");
				const Main = Screen.WaitForChild("Main");
				const Text = Main.FindFirstChild("Money");
				const Old = ConnectedList.get(key);
				// eslint-disable-next-line roblox-ts/lua-truthiness
				if (Old && Text?.IsA("TextLabel")) {
					print(Old, Text.Text.split("/"));
				}
			}
		}
	});
}

if (Lasers) {
	const Childs = Lasers.GetChildren();
	for (const child of Childs) {
		if (child.IsA("Part")) {
			child.Touched.Connect((otherPart) => {
				const Humaniod = otherPart.Parent?.FindFirstChildOfClass("Humanoid");
				if (Humaniod && Humaniod.Parent && !List.has(Humaniod.Parent?.Name)) {
					List.add(Humaniod.Parent?.Name);
					Humaniod.TakeDamage(20);
					wait(0.4);
					List.delete(Humaniod.Parent?.Name);
				}
			});
		}
	}
}

if (Bankkey && Bankkey.IsA("Part") && Door?.IsA("Model")) {
	Bankkey.Touched.Once((otherPart) => {
		const Humanoid = otherPart.Parent?.FindFirstChildOfClass("Humanoid");
		if (Humanoid && Humanoid.Parent) {
			Door.PivotTo(new CFrame(newPosition));
			ConnectedList.set(Humanoid.Parent.Name, 0);
		}
	});
}

if (MoneyKey && MoneyKey.IsA("Part")) {
	MoneyKey.Touched.Connect((otherPart) => {
		const Humanoid = otherPart.Parent?.FindFirstChildOfClass("Humanoid");

		if (Humanoid && Humanoid.Parent) {
			const key = Humanoid.Parent.Name;
			const Player = Players.FindFirstChild(key);

			// eslint-disable-next-line roblox-ts/lua-truthiness
			const Old = ConnectedList.get(key) || 0;
			// print(Old);
			if (typeOf(Old) === "number" && Player?.IsA("Player")) {
				const Guis = Player.WaitForChild("PlayerGui");
				const Screen = Guis?.WaitForChild("Money");
				const Main = Screen.WaitForChild("Main");
				const Text = Main.FindFirstChild("Money");

				if (Screen && Screen.IsA("ScreenGui") && Text?.IsA("TextLabel") && !ListCollector.has(key)) {
					ListCollector.add(key);
					while (wait(2)) {
						if (ListCollector.has(key) === true && ConnectedList.get(key) !== 2000) {
							// eslint-disable-next-line roblox-ts/lua-truthiness
							const money = ConnectedList.get(key) || 0;
							Screen.Enabled = true;

							if (ConnectedList.get(key) === 2000) {
								return ListCollector.delete(key);
							} else {
								ConnectedList.set(key, money + 25);
								Text.Text = "2000" + "/" + (money + 50 > 2000 ? 2000 : money + 50) + "$";
								ListCollector.delete(key);
								wait(2.4);
								ListCollector.add(key);
							}
						}
					}
				}
			}
		}
	});

	MoneyKey.TouchEnded.Connect((otherPart) => {
		const Humanoid = otherPart.Parent?.FindFirstChildOfClass("Humanoid");
		if (Humanoid && Humanoid.Parent) {
			const Old = ConnectedList.get(Humanoid.Parent.Name);
			ListCollector.delete(Humanoid.Parent.Name);
		}
	});
}

Players.PlayerAdded.Connect((player) => {
	player.CharacterAdded.Connect((c) => {
		const Humaniod = c.FindFirstChildOfClass("Humanoid");
		if (Humaniod) {
			Humaniod.WalkSpeed = Humaniod.WalkSpeed + 20;
		}
	});
});
