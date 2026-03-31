import type { AuthUser } from "@/types/auth";
import { createSlice } from "@reduxjs/toolkit";

export interface AuthStateType {
  user: AuthUser | null;
  accessToken: string | null;
  isAuthenticated: boolean;
  isLoading: boolean;
}


const initialState: AuthStateType = {
  user: null,
  accessToken: null,
  isAuthenticated: false,
  isLoading: true
};

export const authSlice = createSlice({
  name: "auth",
  initialState,
  reducers: {
    login: (state, action) => {
      state.user = action.payload.user;
      state.accessToken = action.payload.accessToken;
      state.isAuthenticated = true;
      state.isLoading = false;
    },
    logout: (state) => {
      state.user = null;
      state.accessToken = null;
      state.isAuthenticated = false;
      state.isLoading = false;
    },

    setSession: (state, action) => {
      state.accessToken = action.payload.accessToken;
      state.user = action.payload.user ?? null;
      state.isAuthenticated = true;
      state.isLoading = false;
    },
    setLoading: (state, action) => {
      state.isLoading = action.payload;
    },
  },
});

export const { login, logout, setLoading, setSession } = authSlice.actions;

export default authSlice.reducer;
