import { useEffect } from "react";
import { AppHeader } from "./components/AppHeader.jsx";
import { Workspace } from "./components/Workspace.jsx";
import { initSpineRigTuner } from "./tuner.js";
import "./styles.css";

export default function App() {
  useEffect(() => {
    initSpineRigTuner();
  }, []);

  return (
    <div className="tuner-root">
      <AppHeader />
      <Workspace />
    </div>
  );
}
