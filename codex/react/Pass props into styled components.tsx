// react, styled components, pass props to styled components, z-index

import styled from 'styled-components';

const ConsolePanel = styled.div<{ $displayp: boolean }>`
  z-index: ${ props => props.displayp ? 2 : -1 };
  position: fixed;
  left: 2vh;
  top: 5vh;
  gap: 4vh;
  height: 90vh;
  padding: 2vw;
  border-radius: 20px;
  overflow: auto;

  width: 40vw;

  & pre {
    height: 100%;
    width: 100%;
  }
`;

interface Props {
  debugFunction: (u: unknown) => string;
  show?: boolean;
}

export const DebugConsole = ({ debugFunction, show=true }: Props) => {
  return (
    <ConsolePanel className="console-panel" displayp={ show }>
      <pre>{ debugFunction() }</pre>
    </ConsolePanel>
  );
};

export default DebugConsole;
