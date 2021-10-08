// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;
pragma experimental ABIEncoderV2;

interface ITridentRouter {
    function addLiquidity(
        ITridentRouter.TokenInput[] memory tokenInput,
        address pool,
        uint256 minLiquidity,
        bytes memory data
    ) external payable returns (uint256 liquidity);

    function addLiquidityLazy(
        address pool,
        uint256 minLiquidity,
        bytes memory data
    ) external payable returns (uint256 liquidity);

    function batch(bytes[] memory data)
        external
        payable
        returns (bytes[] memory results);

    function bento() external view returns (address);

    function burnLiquidity(
        address pool,
        uint256 liquidity,
        bytes memory data,
        IPool.TokenAmount[] memory minWithdrawals
    ) external;

    function burnLiquiditySingle(
        address pool,
        uint256 liquidity,
        bytes memory data,
        uint256 minWithdrawal
    ) external;

    function complexPath(ITridentRouter.ComplexPathParams memory params)
        external
        payable;

    function deployPool(address _factory, bytes memory _deployData)
        external
        returns (address);

    function exactInput(ITridentRouter.ExactInputParams memory params)
        external
        payable
        returns (uint256 amountOut);

    function exactInputLazy(
        uint256 amountOutMinimum,
        ITridentRouter.Path[] memory path
    ) external payable returns (uint256 amountOut);

    function exactInputSingle(
        ITridentRouter.ExactInputSingleParams memory params
    ) external payable returns (uint256 amountOut);

    function exactInputSingleWithNativeToken(
        ITridentRouter.ExactInputSingleParams memory params
    ) external payable returns (uint256 amountOut);

    function exactInputWithNativeToken(
        ITridentRouter.ExactInputParams memory params
    ) external payable returns (uint256 amountOut);

    function masterDeployer() external view returns (address);

    function permitThis(
        address token,
        uint256 amount,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    function permitThisAllowed(
        address token,
        uint256 nonce,
        uint256 expiry,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    function refundETH() external payable;

    function sweepBentoBoxToken(
        address token,
        uint256 amount,
        address recipient
    ) external;

    function sweepNativeToken(
        address token,
        uint256 amount,
        address recipient
    ) external;

    function tridentMintCallback(bytes memory data) external;

    function tridentSwapCallback(bytes memory data) external;

    function unwrapWETH(uint256 amountMinimum, address recipient) external;

    receive() external payable;
}

interface ITridentRouter {
    struct TokenInput {
        address token;
        bool native;
        uint256 amount;
    }

    struct ComplexPathParams {
        InitialPath[] initialPath;
        PercentagePath[] percentagePath;
        Output[] output;
    }

    struct InitialPath {
        address tokenIn;
        address pool;
        bool native;
        uint256 amount;
        bytes data;
    }

    struct PercentagePath {
        address tokenIn;
        address pool;
        uint64 balancePercentage;
        bytes data;
    }

    struct Output {
        address token;
        address to;
        bool unwrapBento;
        uint256 minAmount;
    }

    struct ExactInputParams {
        address tokenIn;
        uint256 amountIn;
        uint256 amountOutMinimum;
        Path[] path;
    }

    struct Path {
        address pool;
        bytes data;
    }

    struct ExactInputSingleParams {
        uint256 amountIn;
        uint256 amountOutMinimum;
        address pool;
        address tokenIn;
        bytes data;
    }
}

interface IPool {
    struct TokenAmount {
        address token;
        uint256 amount;
    }
}
